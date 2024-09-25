import 'package:geolocator/geolocator.dart';
import '../entities/weather_data_entity.dart';
import '../repositories/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository _weatherRepository;
  WeatherUseCase({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository;

  Future<WeatherDataEntity> weatherUseCase(Position position) async {
    final response = _weatherRepository.weatherInformation(position);
    return response;
  }


}