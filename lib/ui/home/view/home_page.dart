import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_app_mvvm/core/app_assets.dart';
import 'package:flutter_weather_app_mvvm/ui/home/controller/weather_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../config/build_config.dart';
import '../../../core/app_utils.dart';
import '../model/city.dart';
import '../widget/weather_data_output.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherController controller = Get.put(WeatherController());
  final logger = BuildConfig.instance.config.logger;
  List<City> cityList = [];
  City? selectedCity;

  @override
  void initState() {
    super.initState();
    readCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getInputSection(),
              Obx(() {
                if (controller.isLoading.value) {
                  return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Center(child: CircularProgressIndicator()));
                } else if (controller.hasError.value) {
                  showSnackBar(context, controller.errorMessage.value,
                      type: SnackBarType.ERROR);
                  logger.e(controller.errorMessage.value);
                } else if (!controller.hasError.value) {
                  return WeatherDataOutput(
                      weather: controller.weatherData.value);
                }
                return Container();
              }),
            ],
          ),
        ),
      ),
    );
  }

  _getInputSection() {
    return Container(
        margin: const EdgeInsets.only(top:32.00,bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _getCityDropdown(),
          ],
        ));
  }

  DropdownButton<City> _getCityDropdown() {
    return DropdownButton<City>(
      value: selectedCity,
      onChanged: (City? newCity) {
        setState(() {
          if (newCity != null) selectedCity = newCity;
          showWeather();
        });
      },
      items: cityList.map((City city) {
        return DropdownMenuItem<City>(value: city, child: Text(city.name));
      }).toList(),
    );
  }

  void readCityList() async {
    String response = await rootBundle.loadString(AppAssets.cityList);
    final data = await json.decode(response) as List<dynamic>;
    setState(() {
      cityList = data.map((city) => City.fromJson(city)).toList();
      selectedCity = cityList[0];
      showWeather();
    });
  }

  void showWeather() {
    controller.showWeather(selectedCity);
  }
}
