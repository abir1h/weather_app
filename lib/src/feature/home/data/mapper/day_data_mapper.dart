import 'package:weather_app/src/feature/home/data/mapper/condition_data_mapper.dart';

import '../../domain/entities/Day_data_entity.dart';
import '../models/Day_data_model.dart';

abstract class DayDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DayDataModelToEntityMapper
    extends DayDataMapper<DayDataModel, DayDataEntity> {
  @override
  DayDataModel fromEntityToModel(DayDataEntity entity) {
    return DayDataModel(
        maxtempC: entity.maxtempC,
        maxtempF: entity.maxtempF,
        mintempC: entity.mintempC,
        mintempF: entity.mintempF,
        avgtempC: entity.avgtempC,
        avgtempF: entity.avgtempF,
        maxwindMph: entity.maxwindMph,
        maxwindKph: entity.maxwindKph,
        totalprecipMm: entity.totalprecipMm,
        totalprecipIn: entity.totalprecipIn,
        totalsnowCm: entity.totalsnowCm,
        avgvisKm: entity.avgvisKm,
        avgvisMiles: entity.avgvisMiles,
        avghumidity: entity.avghumidity,
        dailyWillItRain: entity.dailyWillItRain,
        dailyChanceOfRain: entity.dailyChanceOfRain,
        dailyWillItSnow: entity.dailyWillItSnow,
        dailyChanceOfSnow: entity.dailyChanceOfSnow,
        condition: entity.condition.toConditionDataModel,
        uv: entity.uv);
  }

  @override
  DayDataEntity toEntityFromModel(DayDataModel model) {
    return DayDataEntity(
        maxtempC: model.maxtempC,
        maxtempF: model.maxtempF,
        mintempC: model.mintempC,
        mintempF: model.mintempF,
        avgtempC: model.avgtempC,
        avgtempF: model.avgtempF,
        maxwindMph: model.maxwindMph,
        maxwindKph: model.maxwindKph,
        totalprecipMm: model.totalprecipMm,
        totalprecipIn: model.totalprecipIn,
        totalsnowCm: model.totalsnowCm,
        avgvisKm: model.avgvisKm,
        avgvisMiles: model.avgvisMiles,
        avghumidity: model.avghumidity,
        dailyWillItRain: model.dailyWillItRain,
        dailyChanceOfRain: model.dailyChanceOfRain,
        dailyWillItSnow: model.dailyWillItSnow,
        dailyChanceOfSnow: model.dailyChanceOfSnow,
        condition: model.condition.toConditionDataEntity,
        uv: model.uv);
  }
}

extension DayDataModelExt on DayDataModel {
  DayDataEntity get toDayDataEntity =>
      _DayDataModelToEntityMapper().toEntityFromModel(this);
}

extension DayDataEntityExt on DayDataEntity {
  DayDataModel get toDayDataModel =>
      _DayDataModelToEntityMapper().fromEntityToModel(this);
}
