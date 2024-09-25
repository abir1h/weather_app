import 'package:geolocator_platform_interface/src/models/position.dart';
import '../data_sources/remote/weather_data_source.dart';
import '../mapper/weather_data_mapper.dart';
import '../models/weather_data_model.dart';
import '../../domain/entities/weather_data_entity.dart';
import '../../domain/repositories/weather_repository.dart';

import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';

class WeatherRepositoryImp extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImp({required this.weatherRemoteDataSource});

  @override
  Future<WeatherDataEntity> weatherInformation(Position position) async {
    WeatherDataModel weatherDataModel =
        await weatherRemoteDataSource.getWeatherDataAction(position);
    return weatherDataModel.toWeatherDataEntity;
  }
}
