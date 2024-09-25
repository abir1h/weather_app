import 'package:flutter/cupertino.dart';

import 'forcast_day_data_model.dart';

@immutable
class ForecastDataModel {
  final List<ForecastDayDataModel> forecastday;

  const ForecastDataModel({
    required this.forecastday,
  });

  factory ForecastDataModel.fromJson(Map<String, dynamic> json) =>
      ForecastDataModel(
        forecastday:   json["forecastday"]!=null?List<ForecastDayDataModel>.from(
            json["forecastday"].map((x) => ForecastDayDataModel.fromJson(x))):[],
      );

  Map<String, dynamic> toJson() => {
        "forecastday": List<dynamic>.from(forecastday.map((x) => x.toJson())),
      };
}
