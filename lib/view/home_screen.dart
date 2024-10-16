import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/view/widget/weatherUi.dart';

import '../provider/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).fetchWeatherByLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
        elevation: 0,
       // backgroundColor: Colors,
      ),
      body: weatherProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : weatherProvider.weather != null
          ? WeatherUI(weatherProvider: weatherProvider)
          : const Center(child: Text('Unable to fetch weather')),
    );
  }
}





