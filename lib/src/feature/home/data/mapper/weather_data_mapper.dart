import 'package:weather_app/src/feature/home/data/mapper/current_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/mapper/forcast_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/mapper/location_data_mapper.dart';

import '../../domain/entities/weather_data_entity.dart';
import '../models/weather_data_model.dart';

abstract class WeatherDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _WeatherDataModelToEntityMapper
    extends WeatherDataMapper<WeatherDataModel, WeatherDataEntity> {
  @override
  WeatherDataModel fromEntityToModel(WeatherDataEntity entity) {
    return WeatherDataModel(
        location: entity.location!.toLocationDataModel,
        current: entity.current!.toCurrentDataModel,
        forecast: entity.forecast!.toForecastDataModel);
  }

  @override
  WeatherDataEntity toEntityFromModel(WeatherDataModel model) {
    return WeatherDataEntity(
        location: model.location!.toLocationDataEntity,
        current: model.current!.toCurrentDataEntity,
        forecast: model.forecast!.toForecastDataEntity);
  }
}

extension WeatherDataModelExt on WeatherDataModel {
  WeatherDataEntity get toWeatherDataEntity =>
      _WeatherDataModelToEntityMapper().toEntityFromModel(this);
}

extension WeatherDataEntityExt on WeatherDataEntity {
  WeatherDataModel get toWeatherDataModel =>
      _WeatherDataModelToEntityMapper().fromEntityToModel(this);
}
