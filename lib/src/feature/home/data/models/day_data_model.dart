import 'package:flutter/cupertino.dart';
import 'package:weather_app/src/feature/home/data/models/Condition_data_model.dart';

@immutable
class DayDataModel {
  final double maxtempC;
  final double maxtempF;
  final double mintempC;
  final double mintempF;
  final double avgtempC;
  final double avgtempF;
  final double maxwindMph;
  final double maxwindKph;
  final double totalprecipMm;
  final double totalprecipIn;
  final double totalsnowCm;
  final double avgvisKm;
  final double avgvisMiles;
  final int avghumidity;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final ConditionDataModel condition;
  final double uv;

  const DayDataModel({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.maxwindMph,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.totalprecipIn,
    required this.totalsnowCm,
    required this.avgvisKm,
    required this.avgvisMiles,
    required this.avghumidity,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  factory DayDataModel.fromJson(Map<String, dynamic> json) {
    return DayDataModel(
      maxtempC: (json["maxtemp_c"] is int) ? (json["maxtemp_c"] as int).toDouble() : json["maxtemp_c"]?.toDouble(),
      maxtempF: (json["maxtemp_f"] is int) ? (json["maxtemp_f"] as int).toDouble() : json["maxtemp_f"]?.toDouble(),
      mintempC: (json["mintemp_c"] is int) ? (json["mintemp_c"] as int).toDouble() : json["mintemp_c"]?.toDouble(),
      mintempF: (json["mintemp_f"] is int) ? (json["mintemp_f"] as int).toDouble() : json["mintemp_f"]?.toDouble(),
      avgtempC: (json["avgtemp_c"] is int) ? (json["avgtemp_c"] as int).toDouble() : json["avgtemp_c"]?.toDouble(),
      avgtempF: (json["avgtemp_f"] is int) ? (json["avgtemp_f"] as int).toDouble() : json["avgtemp_f"]?.toDouble(),
      maxwindMph: (json["maxwind_mph"] is int) ? (json["maxwind_mph"] as int).toDouble() : json["maxwind_mph"]?.toDouble(),
      maxwindKph: (json["maxwind_kph"] is int) ? (json["maxwind_kph"] as int).toDouble() : json["maxwind_kph"]?.toDouble(),
      totalprecipMm: (json["totalprecip_mm"] is int) ? (json["totalprecip_mm"] as int).toDouble() : json["totalprecip_mm"]?.toDouble(),
      totalprecipIn: (json["totalprecip_in"] is int) ? (json["totalprecip_in"] as int).toDouble() : json["totalprecip_in"]?.toDouble(),
      totalsnowCm: (json["totalsnow_cm"] is int) ? (json["totalsnow_cm"] as int).toDouble() : json["totalsnow_cm"]?.toDouble(),
      avgvisKm: (json["avgvis_km"] is int) ? (json["avgvis_km"] as int).toDouble() : json["avgvis_km"]?.toDouble(),
      avgvisMiles: (json["avgvis_miles"] is int) ? (json["avgvis_miles"] as int).toDouble() : json["avgvis_miles"]?.toDouble(),
      avghumidity: json["avghumidity"]?.toInt() ?? 0,
      dailyWillItRain: json["daily_will_it_rain"]?.toInt() ?? 0,
      dailyChanceOfRain: json["daily_chance_of_rain"]?.toInt() ?? 0,
      dailyWillItSnow: json["daily_will_it_snow"]?.toInt() ?? 0,
      dailyChanceOfSnow: json["daily_chance_of_snow"]?.toInt() ?? 0,
      condition: ConditionDataModel.fromJson(json["condition"]),
      uv: (json["uv"] is int) ? (json["uv"] as int).toDouble() : json["uv"]?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "maxtemp_c": maxtempC,
    "maxtemp_f": maxtempF,
    "mintemp_c": mintempC,
    "mintemp_f": mintempF,
    "avgtemp_c": avgtempC,
    "avgtemp_f": avgtempF,
    "maxwind_mph": maxwindMph,
    "maxwind_kph": maxwindKph,
    "totalprecip_mm": totalprecipMm,
    "totalprecip_in": totalprecipIn,
    "totalsnow_cm": totalsnowCm,
    "avgvis_km": avgvisKm,
    "avgvis_miles": avgvisMiles,
    "avghumidity": avghumidity,
    "daily_will_it_rain": dailyWillItRain,
    "daily_chance_of_rain": dailyChanceOfRain,
    "daily_will_it_snow": dailyWillItSnow,
    "daily_chance_of_snow": dailyChanceOfSnow,
    "condition": condition.toJson(),
    "uv": uv,
  };
}
