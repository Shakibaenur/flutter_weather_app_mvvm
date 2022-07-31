import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_app_mvvm/ui/home/view/home_page.dart';
import 'package:logger/logger.dart';

import 'config/build_config.dart';
import 'config/env.config.dart';
import 'core/app_assets.dart';

Future<void> main() async {
  var logger = Logger();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    EnvConfig config = await getConfig();
    BuildConfig.instantiate(envConfig: config);
    runApp(MyApp());
  } catch (e) {
    logger.e(e);
  }
}

class MyApp extends StatelessWidget {
  final String appTitle = 'Flutter Weather App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: HomePage(title: appTitle),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<EnvConfig> getConfig() async {
  var logger = Logger();
  try {
    String configString = await rootBundle.loadString(AppAssets.config);
    final configJson = await json.decode(configString) as Map<String, dynamic>;

    String baseUrl = configJson['baseUrl'];
    String appId = configJson['appId'];

    if(baseUrl.isEmpty || appId.isEmpty)
      logger.e('Base URL and AppID should not empty. '
          'Please follow the guideline for configuring this project.\n'
          'Guideline: https://github.com/hasancse91/weather_app_flutter');

    return EnvConfig(
      baseUrl: baseUrl,
      appId: appId,
    );
  } catch (e) {
    throw Exception('$e\nLocal configuration NOT found. '
        'Please follow the guideline for configuring this project.\n'
        'Guideline: https://github.com/hasancse91/weather_app_flutter');
  }
}