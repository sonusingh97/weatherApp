import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/weatherModel.dart';

class ForecastCard extends StatelessWidget {
  final Forecast forecast;

  const ForecastCard({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('EEE,d').format(forecast.date),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            DateFormat('h:mm a').format(forecast.date),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),

          Image.network(
            'https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png', // Weather icon
            height: 40,
            width: 40,
          ),
          const SizedBox(height: 5),
          Text(
            '${forecast.temperature.toStringAsFixed(1)}°C',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}