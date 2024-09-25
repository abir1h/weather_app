import 'forcast_day_data_mapper.dart';
import '../models/forcast_day_data_model.dart';
import '../../domain/entities/forcast_day_data_entity.dart';
import '../../domain/entities/forcast_data_entity.dart';
import '../models/forcast_data_model.dart';

abstract class ForecastDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ForecastDataModelToEntityMapper
    extends ForecastDataMapper<ForecastDataModel, ForecastDataEntity> {
  @override
  ForecastDataModel fromEntityToModel(ForecastDataEntity entity) {
    return ForecastDataModel(
        forecastday: List<ForecastDayDataEntity>.from(entity.forecastday)
            .map((entity) => entity.toForecastDayDataModel)
            .toList());
  }

  @override
  ForecastDataEntity toEntityFromModel(ForecastDataModel model) {
    return ForecastDataEntity(
      forecastday: List<ForecastDayDataModel>.from(model.forecastday)
          .map((model) => model.toForecastDayDataEntity)
          .toList(),
    );
  }
}

extension ForecastDataModelExt on ForecastDataModel {
  ForecastDataEntity get toForecastDataEntity =>
      _ForecastDataModelToEntityMapper().toEntityFromModel(this);
}

extension ForecastDataEntityExt on ForecastDataEntity {
  ForecastDataModel get toForecastDataModel =>
      _ForecastDataModelToEntityMapper().fromEntityToModel(this);
}
