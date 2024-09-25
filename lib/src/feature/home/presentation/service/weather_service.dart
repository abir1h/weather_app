import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:weather_app/src/feature/home/data/data_sources/remote/weather_data_source.dart';
import 'package:weather_app/src/feature/home/data/mapper/current_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/mapper/forcast_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/mapper/location_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/repositories/weather_repository_imp.dart';
import 'package:weather_app/src/feature/home/domain/entities/weather_data_entity.dart';
import 'dart:developer';

import 'package:weather_app/src/feature/home/domain/use_cases/weather_use_case.dart';

import '../../data/data_sources/local_data_source/db_helper.dart';
import '../../data/models/weather_data_model.dart';

class UnitNotifier extends StateNotifier<String> {
  UnitNotifier() : super("Celsius");

  void toggleUnit() {
    state = (state == "Celsius") ? "Fahrenheit" : "Celsius";
  }
}

final unitProvider = StateNotifierProvider<UnitNotifier, String>((ref) {
  return UnitNotifier();
});

final locationProvider = FutureProvider<Position>((ref) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
});

final WeatherUseCase _weatherUseCase = WeatherUseCase(
  weatherRepository: WeatherRepositoryImp(
    weatherRemoteDataSource: WeatherRemoteDataSourceImp(),
  ),
);


final weatherProvider = FutureProvider.family<WeatherDataModel, Position>((ref, position) async {
  final weatherDbHelper = WeatherDatabaseHelper();
  final positionKey = position.toString();

  // Check for internet connectivity
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    // No internet, load weather data from the SQLite database
    WeatherDataModel? cachedData = await weatherDbHelper.getWeatherData(positionKey);
    if (cachedData != null) {
      return cachedData;
    } else {
      throw Exception('No internet and no cached data available');
    }
  } else {
    try {
      // Fetch data from the API (returns WeatherDataEntity)
      WeatherDataEntity weatherDataEntity = await _weatherUseCase.weatherUseCase(position);

      // Convert WeatherDataEntity to WeatherDataModel
      WeatherDataModel weatherDataModel = WeatherDataModel(
        location: weatherDataEntity.location!.toLocationDataModel,
        current: weatherDataEntity.current!.toCurrentDataModel,
        forecast: weatherDataEntity.forecast!.toForecastDataModel,
      );

      // Store the data in the SQLite database for offline access
      await weatherDbHelper.insertWeatherData(weatherDataModel, positionKey);

      return weatherDataModel;
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
});

final locationAddressProvider = FutureProvider.family<String, Position>((ref, position) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    return "${place.locality}"; // Customize as needed
  } catch (e) {
    return "Location not found";
  }
});
final selectedTabProvider = StateProvider<int>((ref) => 0);
