import '../ui/home/model/weather_data.dart';

abstract class WeatherApi {
  Future<WeatherData>? getWeatherInfo(int? cityId);
}
