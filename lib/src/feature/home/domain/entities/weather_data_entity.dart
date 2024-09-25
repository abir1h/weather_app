import 'current_data_entity.dart';
import 'forcast_data_entity.dart';
import 'location_data_entity.dart';

class WeatherDataEntity {
  final LocationDataEntity? location;
  final CurrentDataEntity? current;
  final ForecastDataEntity? forecast;

  WeatherDataEntity({
    required this.location,
    required this.current,
    required this.forecast,
  });
}