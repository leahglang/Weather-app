import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weater_model.dart';


// class WeatherService {
//   static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
//   static const GEO_URL = 'http://api.openweathermap.org/geo/1.0/direct';

//   final String apiKey;

//   WeatherService(this.apiKey);

//   Future<Weather> getWeather(String cityName) async {
//     final response = await http.get
//     (Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

//     if(response.statusCode == 200){
//       return Weather.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }


class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  static const GEO_URL = 'http://api.openweathermap.org/geo/1.0/direct';

  final String apikey;

  WeatherService(this.apikey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get
    (Uri.parse('$BASE_URL?q=$cityName&appid=$apikey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  Future<List<String>> getCitySuggestions(String query) async {
    final response = await http.get
    (Uri.parse('$GEO_URL?q=$query&limit=5&appid=$apikey'));

    if(response.statusCode == 200){
      final List data = json.decode(response.body);
      return data.map<String>((json) => ['name'] as String).toList();
    }else{
      throw Exception('Failed to fatch city suggestions');
    }
  }

}

