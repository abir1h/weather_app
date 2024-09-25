

import '../../domain/entities/astro_data_entity.dart';
import '../models/astro_data_model.dart';

abstract class AstroDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _AstroDataModelToEntityMapper
    extends AstroDataMapper<AstroDataModel, AstroDataEntity> {
  @override
  AstroDataModel fromEntityToModel(AstroDataEntity entity) {
    return AstroDataModel(
        sunrise: entity.sunrise,
        sunset: entity.sunset,
        moonrise: entity.moonrise,
        moonset: entity.moonset,
        moonPhase: entity.moonPhase,
        moonIllumination: entity.moonIllumination,
        isMoonUp: entity.isMoonUp,
        isSunUp: entity.isSunUp);
  }

  @override
  AstroDataEntity toEntityFromModel(AstroDataModel model) {
    return AstroDataEntity(
        sunrise: model.sunrise,
        sunset: model.sunset,
        moonrise: model.moonrise,
        moonset: model.moonset,
        moonPhase: model.moonPhase,
        moonIllumination:model. moonIllumination,
        isMoonUp: model.isMoonUp,
        isSunUp: model.isSunUp);
  }
}

extension AstroDataModelExt on AstroDataModel {
  AstroDataEntity get toAstroDataEntity =>
      _AstroDataModelToEntityMapper().toEntityFromModel(this);
}

extension AstroDataEntityExt on AstroDataEntity {
  AstroDataModel get toAstroDataModel =>
      _AstroDataModelToEntityMapper().fromEntityToModel(this);
}
