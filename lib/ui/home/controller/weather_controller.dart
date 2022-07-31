import 'package:get/get.dart';

import '../../../network/weather_api.dart';
import '../../../network/weather_api_impl.dart';
import '../model/city.dart';
import '../model/weather_data.dart';

class WeatherController extends GetxController {
  late WeatherApi weatherApi = WeatherApiImpl();
  WeatherData? weather;
  final weatherData=WeatherData().obs;
  RxBool isLoading = false.obs;

  RxBool hasError = false.obs;
  RxString errorMessage = "".obs;

  showWeather(City? selectedCity) async {
    Future.microtask(() => isLoading(true));
    hasError(false);
    try {
      var weatherTemp = await weatherApi.getWeatherInfo(selectedCity?.id);
      weather = weatherTemp;
      weatherData(weatherTemp);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      hasError(true);
      errorMessage(e.toString());
    }
    isLoading(false);
  }
}
