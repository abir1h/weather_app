import 'package:flutter/cupertino.dart';

import 'Day_data_model.dart';
import 'astro_data_model.dart';
import 'current_data_model.dart';

@immutable
class ForecastDayDataModel {
  final DateTime date;
  final int dateEpoch;
  final DayDataModel day;
  final AstroDataModel astro;
  final List<CurrentDataModel> hour;

  const ForecastDayDataModel({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDayDataModel.fromJson(Map<String, dynamic> json) =>
      ForecastDayDataModel(
        date: DateTime.parse(json["date"]),
        dateEpoch: json["date_epoch"],
        day: DayDataModel.fromJson(json["day"]),
        astro: AstroDataModel.fromJson(json["astro"]),
        hour: List<CurrentDataModel>.from(
            json["hour"].map((x) => CurrentDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "date_epoch": dateEpoch,
        "day": day.toJson(),
        "astro": astro.toJson(),
        "hour": List<dynamic>.from(hour.map((x) => x.toJson())),
      };
}
