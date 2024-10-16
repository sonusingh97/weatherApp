import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../model/weatherModel.dart';
import '../services/weather_services.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  bool _isLoading = false;

  WeatherModel? get weather => _weather;

  bool get isLoading => _isLoading;


  Future<void> fetchWeatherByLocation() async {
    _isLoading = true;
    notifyListeners();

    try {
      Position position = await _determinePosition();
      _weather = await _weatherService.fetchWeatherByLocation(
          position.latitude, position.longitude);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
