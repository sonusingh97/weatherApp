import 'package:weatherapp/view/widget/forecastCard.dart';

import '../../provider/weather_provider.dart';

import 'package:flutter/material.dart';

class WeatherUI extends StatelessWidget {
  final WeatherProvider weatherProvider;

  const WeatherUI({Key? key, required this.weatherProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = weatherProvider.weather;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(
                      weather!.city,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Image.network(
                      'https://openweathermap.org/img/wn/${weather.icon}@2x.png', // Weather icon

                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${weather.temperature}°C',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      weather.description.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weather.forecast.length,
                    itemBuilder: (context, index) {
                      final forecast = weather.forecast[index];
                      print(forecast.date);
                      return ForecastCard(forecast: forecast);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
