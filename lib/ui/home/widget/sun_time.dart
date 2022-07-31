import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_app_mvvm/core/app_assets.dart';

import 'Item_sun_time.dart';

class SunTime extends StatelessWidget {
  final String sunrise;
  final String sunset;

  const SunTime({
    Key? key,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ItemSunTime(
          label: "Sunrise",
          value: sunrise,
          imagePath: AppAssets.sunrise,
        ),
        ItemSunTime(
          label: "Sunset",
          value: sunset,
          imagePath: AppAssets.sunset,
        ),
      ],
    );
  }
}