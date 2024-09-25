import 'package:weather_app/src/feature/home/data/mapper/astro_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/mapper/current_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/mapper/day_data_mapper.dart';
import 'package:weather_app/src/feature/home/data/models/current_data_model.dart';
import 'package:weather_app/src/feature/home/domain/entities/current_data_entity.dart';

import '../../domain/entities/forcast_day_data_entity.dart';
import '../models/forcast_day_data_model.dart';

abstract class ForecastDayDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ForecastDayDataModelToEntityMapper
    extends ForecastDayDataMapper<ForecastDayDataModel, ForecastDayDataEntity> {
  @override
  ForecastDayDataModel fromEntityToModel(ForecastDayDataEntity entity) {
    return ForecastDayDataModel(
        date: entity.date,
        dateEpoch: entity.dateEpoch,
        day: entity.day.toDayDataModel,
        astro: entity.astro.toAstroDataModel,
        hour: List<CurrentDataEntity>.from(entity.hour)
            .map((entity) => entity.toCurrentDataModel)
            .toList());
  }

  @override
  ForecastDayDataEntity toEntityFromModel(ForecastDayDataModel model) {
    return ForecastDayDataEntity(
      date: model.date,
      dateEpoch: model.dateEpoch,
      day: model.day.toDayDataEntity,
      astro: model.astro.toAstroDataEntity,
      hour: List<CurrentDataModel>.from(model.hour)
          .map((model) => model.toCurrentDataEntity)
          .toList(),
    );
  }
}

extension ForecastDayDataModelExt on ForecastDayDataModel {
  ForecastDayDataEntity get toForecastDayDataEntity =>
      _ForecastDayDataModelToEntityMapper().toEntityFromModel(this);
}

extension ForecastDayDataEntityExt on ForecastDayDataEntity {
  ForecastDayDataModel get toForecastDayDataModel =>
      _ForecastDayDataModelToEntityMapper().fromEntityToModel(this);
}
