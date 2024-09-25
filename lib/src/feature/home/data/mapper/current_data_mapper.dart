import 'package:weather_app/src/feature/home/data/mapper/condition_data_mapper.dart';

import '../../domain/entities/current_data_entity.dart';
import '../models/current_data_model.dart';

abstract class CurrentDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CurrentDataModelToEntityMapper
    extends CurrentDataMapper<CurrentDataModel, CurrentDataEntity> {
  @override
  CurrentDataModel fromEntityToModel(CurrentDataEntity entity) {
    return CurrentDataModel(
      tempC: entity.tempC,
      tempF: entity.tempF,
      isDay: entity.isDay,
      condition: entity.condition.toConditionDataModel,
      windMph: entity.windMph,
      windKph: entity.windKph,
      windDegree: entity.windDegree,
      windDir: entity.windDir,
      pressureMb: entity.pressureMb,
      pressureIn: entity.pressureIn,
      precipMm: entity.precipMm,
      precipIn: entity.precipIn,
      humidity: entity.humidity,
      cloud: entity.cloud,
      feelslikeC: entity.feelslikeC,
      feelslikeF: entity.feelslikeF,
      windchillC: entity.windchillC,
      windchillF: entity.windchillF,
      heatindexC: entity.heatindexC,
      heatindexF: entity.heatindexF,
      dewpointC: entity.dewpointC,
      dewpointF: entity.dewpointF,
      visKm: entity.visKm,
      visMiles: entity.visMiles,
      uv: entity.uv,
      gustMph: entity.gustMph,
      gustKph: entity.gustKph,
      chanceOfRain: entity.chanceOfRain,
      chanceOfSnow: entity.chanceOfSnow,
      lastUpdated: entity.lastUpdated,
      lastUpdatedEpoch: entity.lastUpdatedEpoch,
      snowCm: entity.snowCm,
      time: entity.time,
      timeEpoch: entity.timeEpoch,
      willItRain: entity.willItRain,
      willItSnow: entity.willItSnow,
    );
  }

  @override
  CurrentDataEntity toEntityFromModel(CurrentDataModel model) {
    return CurrentDataEntity(
      tempC: model.tempC,
      tempF: model.tempF,
      isDay: model.isDay,
      condition: model.condition.toConditionDataEntity,
      windMph: model.windMph,
      windKph: model.windKph,
      windDegree: model.windDegree,
      windDir: model.windDir,
      pressureMb: model.pressureMb!,
      pressureIn: model.pressureIn,
      precipMm: model.precipMm,
      precipIn: model.precipIn,
      humidity: model.humidity,
      cloud: model.cloud,
      feelslikeC: model.feelslikeC,
      feelslikeF: model.feelslikeF,
      windchillC: model.windchillC,
      windchillF: model.windchillF,
      heatindexC: model.heatindexC,
      heatindexF: model.heatindexF,
      dewpointC: model.dewpointC,
      dewpointF: model.dewpointF,
      visKm: model.visKm,
      visMiles: model.visMiles,
      uv: model.uv,
      gustMph: model.gustMph,
      gustKph: model.gustKph,
      chanceOfRain: model.chanceOfRain,
      chanceOfSnow: model.chanceOfSnow,
      lastUpdated: model.lastUpdated,
      lastUpdatedEpoch: model.lastUpdatedEpoch,
      snowCm: model.snowCm,
      time: model.time,
      timeEpoch: model.timeEpoch,
      willItRain: model.willItRain,
      willItSnow: model.willItSnow,
    );
  }
}

extension CurrentDataModelExt on CurrentDataModel {
  CurrentDataEntity get toCurrentDataEntity =>
      _CurrentDataModelToEntityMapper().toEntityFromModel(this);
}

extension CurrentDataEntityExt on CurrentDataEntity {
  CurrentDataModel get toCurrentDataModel =>
      _CurrentDataModelToEntityMapper().fromEntityToModel(this);
}
