import '../../domain/entities/Condition_data_entity.dart';
import '../models/Condition_data_model.dart';

abstract class ConditionDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ConditionDataModelToEntityMapper
    extends ConditionDataMapper<ConditionDataModel, ConditionDataEntity> {
  @override
  ConditionDataModel fromEntityToModel(ConditionDataEntity entity) {
    return ConditionDataModel(
        text: entity.text, icon: entity.icon, code: entity.code);
  }

  @override
  ConditionDataEntity toEntityFromModel(ConditionDataModel model) {
    return ConditionDataEntity(
        text: model.text, icon: model.icon, code: model.code);
  }
}

extension ConditionDataModelExt on ConditionDataModel {
  ConditionDataEntity get toConditionDataEntity =>
      _ConditionDataModelToEntityMapper().toEntityFromModel(this);
}

extension ConditionDataEntityExt on ConditionDataEntity {
  ConditionDataModel get toConditionDataModel =>
      _ConditionDataModelToEntityMapper().fromEntityToModel(this);
}
