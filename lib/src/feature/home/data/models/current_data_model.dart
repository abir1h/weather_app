import 'package:flutter/cupertino.dart';
import 'Condition_data_model.dart';

@immutable
class CurrentDataModel {
  final int? lastUpdatedEpoch;
  final String? lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final ConditionDataModel condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double? pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double windchillC;
  final double windchillF;
  final double heatindexC;
  final double heatindexF;
  final double dewpointC;
  final double dewpointF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;
  final int? timeEpoch;
  final String? time;
  final int? snowCm;
  final int? willItRain;
  final int? chanceOfRain;
  final int? willItSnow;
  final int? chanceOfSnow;

  const CurrentDataModel({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.windchillC,
    required this.windchillF,
    required this.heatindexC,
    required this.heatindexF,
    required this.dewpointC,
    required this.dewpointF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
    this.timeEpoch,
    this.time,
    this.snowCm,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
  });

  factory CurrentDataModel.fromJson(Map<String, dynamic> json) {
    return CurrentDataModel(
      lastUpdatedEpoch: json["last_updated_epoch"] is int ? json["last_updated_epoch"] as int : null,
      lastUpdated: json["last_updated"],
      tempC: (json["temp_c"] is num) ? (json["temp_c"] as num).toDouble() : 0.0,
      tempF: (json["temp_f"] is num) ? (json["temp_f"] as num).toDouble() : 0.0,
      isDay: json["is_day"] is int ? json["is_day"] as int : 0,
      condition: ConditionDataModel.fromJson(json["condition"]),
      windMph: (json["wind_mph"] is num) ? (json["wind_mph"] as num).toDouble() : 0.0,
      windKph: (json["wind_kph"] is num) ? (json["wind_kph"] as num).toDouble() : 0.0,
      windDegree: json["wind_degree"] is int ? json["wind_degree"] as int : 0,
      windDir: json["wind_dir"] as String? ?? "",
      pressureMb: (json["pressure_mb"] is num) ? (json["pressure_mb"] as num).toDouble() : null,
      pressureIn: (json["pressure_in"] is num) ? (json["pressure_in"] as num).toDouble() : 0.0,
      precipMm: (json["precip_mm"] is num) ? (json["precip_mm"] as num).toDouble() : 0.0,
      precipIn: (json["precip_in"] is num) ? (json["precip_in"] as num).toDouble() : 0.0,
      humidity: json["humidity"] is int ? json["humidity"] as int : 0,
      cloud: json["cloud"] is int ? json["cloud"] as int : 0,
      feelslikeC: (json["feelslike_c"] is num) ? (json["feelslike_c"] as num).toDouble() : 0.0,
      feelslikeF: (json["feelslike_f"] is num) ? (json["feelslike_f"] as num).toDouble() : 0.0,
      windchillC: (json["windchill_c"] is num) ? (json["windchill_c"] as num).toDouble() : 0.0,
      windchillF: (json["windchill_f"] is num) ? (json["windchill_f"] as num).toDouble() : 0.0,
      heatindexC: (json["heatindex_c"] is num) ? (json["heatindex_c"] as num).toDouble() : 0.0,
      heatindexF: (json["heatindex_f"] is num) ? (json["heatindex_f"] as num).toDouble() : 0.0,
      dewpointC: (json["dewpoint_c"] is num) ? (json["dewpoint_c"] as num).toDouble() : 0.0,
      dewpointF: (json["dewpoint_f"] is num) ? (json["dewpoint_f"] as num).toDouble() : 0.0,
      visKm: (json["vis_km"] is num) ? (json["vis_km"] as num).toDouble() : 0.0,
      visMiles: (json["vis_miles"] is num) ? (json["vis_miles"] as num).toDouble() : 0.0,
      uv: (json["uv"] is num) ? (json["uv"] as num).toDouble() : 0.0,
      gustMph: (json["gust_mph"] is num) ? (json["gust_mph"] as num).toDouble() : 0.0,
      gustKph: (json["gust_kph"] is num) ? (json["gust_kph"] as num).toDouble() : 0.0,
      timeEpoch: json["time_epoch"] is int ? json["time_epoch"] as int : null,
      time:  json["time"],
      snowCm: json["snow_cm"] is int ? json["snow_cm"] as int : null,
      willItRain: json["will_it_rain"] is int ? json["will_it_rain"] as int : null,
      chanceOfRain: json["chance_of_rain"] is int ? json["chance_of_rain"] as int : null,
      willItSnow: json["will_it_snow"] is int ? json["will_it_snow"] as int : null,
      chanceOfSnow: json["chance_of_snow"] is int ? json["chance_of_snow"] as int : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "windchill_c": windchillC,
    "windchill_f": windchillF,
    "heatindex_c": heatindexC,
    "heatindex_f": heatindexF,
    "dewpoint_c": dewpointC,
    "dewpoint_f": dewpointF,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "uv": uv,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
    "time_epoch": timeEpoch,
    "time": time,
    "snow_cm": snowCm,
    "will_it_rain": willItRain,
    "chance_of_rain": chanceOfRain,
    "will_it_snow": willItSnow,
    "chance_of_snow": chanceOfSnow,
  };
}
