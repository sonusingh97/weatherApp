class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final List<Forecast> forecast;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.forecast,
  });

  // Factory method to create a WeatherModel from JSON response
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<Forecast> forecastList = (json['forecast'] as List)
        .map((data) => Forecast.fromJson(data))
        .toList();

    return WeatherModel(
      city: json['city']['name'],
      temperature: json['current']['temp'],
      description: json['current']['weather'][0]['description'],
      icon: json['current']['weather'][0]['icon'],
      forecast: forecastList,
    );
  }
}

class Forecast {
  final DateTime date; // Changed from String to DateTime for easier formatting
  final double temperature;
  final String description;
  final String iconCode;

  Forecast({
    required this.date,
    required this.temperature,
    required this.description,
    required this.iconCode,
  });

  // Factory method to create a Forecast object from JSON response
  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000), // Convert Unix timestamp to DateTime
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'], // Extract icon code from weather data
    );
  }
}
