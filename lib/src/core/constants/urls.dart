class ApiCredential {
  const ApiCredential._();

  static String baseUrl =
      "http://api.weatherapi.com/v1"; // Development Server

  static String getWeatherData = "/forecast.json";
}
