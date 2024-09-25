import 'Day_data_entity.dart';
import 'astro_data_entity.dart';
import 'current_data_entity.dart';

class ForecastDayDataEntity {
  final DateTime date;
  final int dateEpoch;
  final DayDataEntity day;
  final AstroDataEntity astro;
  final List<CurrentDataEntity> hour;

  const ForecastDayDataEntity({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });
}
