import 'package:geolocator/geolocator.dart';
import '../../models/weather_data_model.dart';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

// Replace with your WeatherAPI API key
const String apiKey = "8aeb9dcee4f34e41acb42750242509";
const String apiUrl = "http://api.weatherapi.com/v1";

abstract class WeatherRemoteDataSource {
  Future<WeatherDataModel> getWeatherDataAction(Position position);
}

class WeatherRemoteDataSourceImp extends WeatherRemoteDataSource {
  @override
  Future<WeatherDataModel> getWeatherDataAction(Position position) async {
    final responseJson = await Server.instance.getRequest(
        url:
            "${ApiCredential.getWeatherData}?key=$apiKey&q=${position.latitude},${position.longitude}&days=4&aqi=no&alerts=no");
    WeatherDataModel responseModel = WeatherDataModel.fromJson(responseJson);
    return responseModel;
  }
}
