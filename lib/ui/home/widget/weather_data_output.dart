
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_app_mvvm/ui/home/widget/sun_time.dart';
import 'package:flutter_weather_app_mvvm/ui/home/widget/temperature_section.dart';
import 'package:flutter_weather_app_mvvm/ui/home/widget/weather_property.dart';

import '../model/weather_data.dart';

class WeatherDataOutput extends StatelessWidget {
  final WeatherData weather;

  const WeatherDataOutput({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TemperatureSection(
            dateTime: weather.dateTime==null||weather.dateTime==""?"":weather.dateTime!,
            temperature: weather.temperature==null||weather.temperature==""?"":weather.temperature!,
            iconUrl: weather.weatherConditionIconUrl==null||weather.weatherConditionIconUrl==""?"":weather.weatherConditionIconUrl!,
            description: weather.weatherConditionIconDescription==null||weather.weatherConditionIconDescription==""?"":weather.weatherConditionIconDescription!,
            cityAndCountry: weather.cityAndCountry==null||weather.cityAndCountry==""?"":weather.cityAndCountry!,
          ),
          SizedBox(height: 16),
          WeatherProperty(
            humidity: weather.humidity==null||weather.humidity==""?"":weather.humidity!,
            pressure: weather.pressure==null||weather.pressure==""?"":weather.pressure!,
            visibility: weather.visibility==null||weather.visibility==""?"":weather.visibility!,
          ),
          Spacer(),
          SunTime(sunrise: weather.sunrise==null||weather.sunrise==""?"":weather.sunrise!, sunset: weather.sunset==null||weather.sunset==""?"":weather.sunset!),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}