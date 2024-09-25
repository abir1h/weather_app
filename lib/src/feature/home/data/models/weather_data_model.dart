
import 'package:flutter/cupertino.dart';

import 'current_data_model.dart';
import 'forcast_data_model.dart';
import 'location_data_model.dart';

class WeatherDataModel {
  final LocationDataModel? location;
  final CurrentDataModel? current;
  final ForecastDataModel? forecast;

  const WeatherDataModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) => WeatherDataModel(
    location: json["location"]!=null?LocationDataModel.fromJson(json["location"]):null,
    current: json["current"]!=null?CurrentDataModel.fromJson(json["current"]):null,
    forecast: json["forecast"]!=null?ForecastDataModel.fromJson(json["forecast"]):null,
  );

  Map<String, dynamic> toJson() => {
    "location": location!.toJson(),
    "current": current!.toJson(),
    "forecast": forecast!.toJson(),
  };
}



