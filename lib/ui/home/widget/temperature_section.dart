
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app_mvvm/core/app_assets.dart';

import '../../../core/text_style.dart';

class TemperatureSection extends StatelessWidget {
  final String dateTime;
  final String temperature;
  final String iconUrl;
  final String description;
  final String cityAndCountry;

  const TemperatureSection({
    Key? key,
    required this.dateTime,
    required this.temperature,
    required this.iconUrl,
    required this.description,
    required this.cityAndCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dateTime, style: valueTextStyle),
        _getTemperatureRow(),
        Text(cityAndCountry, style: titleTextStyle)
      ],
    );
  }

  _getTemperatureRow() {
    return Row(
      children: <Widget>[
        Text(temperature, style: extraLargeTitleTextStyle),
        const Text('°C', style: TextStyle(fontSize: 35, color: Colors.teal)),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.network(iconUrl, width: 60, height: 60),
            FadeInImage(
              width: 60,
              height: 60,
              image: NetworkImage(iconUrl),
              placeholder: const AssetImage(AppAssets.placeholder),
              imageErrorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
              fit: BoxFit.fitWidth,
            ),
            Text(description),
          ],
        )
      ],
    );
  }
}