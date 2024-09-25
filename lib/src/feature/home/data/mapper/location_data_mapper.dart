import '../../domain/entities/location_data_entity.dart';
import '../models/location_data_model.dart';

abstract class LocationDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _LocationDataModelToEntityMapper
    extends LocationDataMapper<LocationDataModel, LocationDataEntity> {
  @override
  LocationDataModel fromEntityToModel(LocationDataEntity entity) {
    return LocationDataModel(
        name: entity.name,
        region: entity.region,
        country: entity.country,
        lat: entity.lat,
        lon: entity.lon,
        tzId: entity.tzId,
        localtimeEpoch: entity.localtimeEpoch,
        localtime: entity.localtime);
  }

  @override
  LocationDataEntity toEntityFromModel(LocationDataModel model) {
    return LocationDataEntity(
        name: model.name,
        region:  model.region,
        country:  model.country,
        lat:  model.lat,
        lon:  model.lon,
        tzId:  model.tzId,
        localtimeEpoch:  model.localtimeEpoch,
        localtime:  model.localtime);
  }
}

extension LocationDataModelExt on LocationDataModel {
  LocationDataEntity get toLocationDataEntity =>
      _LocationDataModelToEntityMapper().toEntityFromModel(this);
}

extension LocationDataEntityExt on LocationDataEntity {
  LocationDataModel get toLocationDataModel =>
      _LocationDataModelToEntityMapper().fromEntityToModel(this);
}
