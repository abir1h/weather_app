import 'package:geolocator/geolocator.dart';
import '../entities/weather_data_entity.dart';


abstract class WeatherRepository {
  Future<WeatherDataEntity> weatherInformation(Position position);
}
