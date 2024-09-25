import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:weather_app/src/feature/home/data/data_sources/remote/weather_data_source.dart';
import 'package:weather_app/src/feature/home/data/repositories/weather_repository_imp.dart';
import 'package:weather_app/src/feature/home/domain/entities/weather_data_entity.dart';
import 'dart:developer';

import 'package:weather_app/src/feature/home/domain/use_cases/weather_use_case.dart';

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


final weatherProvider =
    FutureProvider.family<WeatherDataEntity, Position>((ref, position) async {
  try {
    WeatherDataEntity weatherData =
        await _weatherUseCase.weatherUseCase(position);

    return weatherData;
  } catch (e) {
    throw Exception('Failed to load weather data: $e');
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
