import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/weatherModel.dart';


class WeatherService {
  final String apiKey = '15d8f0581a5a9f34156ee9c2009ad32d';


  Future<WeatherModel> fetchWeatherByLocation(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temperature = data['main']['temp'].toDouble();
      final description = data['weather'][0]['description'];
      final icon = data['weather'][0]['icon'];
      final cityName = data['name'];


      List<Forecast> forecast = await fetchForecastByLocation(latitude, longitude);

      return WeatherModel(
        city: cityName,
        temperature: temperature,
        description: description,
        icon: icon,
        forecast: forecast,
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Forecast>> fetchForecastByLocation(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> forecastList = data['list'];

      return forecastList.map((forecastData) {
        final date = DateTime.parse(forecastData['dt_txt']);
        final temperature = forecastData['main']['temp'].toDouble();
        final description = forecastData['weather'][0]['description'];
        final iconCode = forecastData['weather'][0]['icon'];

        return Forecast(
          date: date,
          temperature: temperature,
          description: description,
          iconCode: iconCode,
        );
      }).toList();
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
