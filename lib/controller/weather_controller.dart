import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather/constants.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController{
  var isLoading=false.obs;
var temp=''.obs;
var hum=''.obs;
var wind=''.obs;

  getWeatherData()async{
    isLoading.value=true;
    String city = 'Delhi';
    String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$API_KEY';
  try{
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var weather = data['weather'][0]['main'];
      temp.value="${(data['main']['temp'] - 273.15).toStringAsFixed(1)}";
      hum.value="${data['main']['humidity']}";
      wind.value="${data['wind']['speed']}";
      print('Weather: $weather');
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
    isLoading.value=false;
  }catch(e){
    isLoading.value=false;
    debugPrint('Error: $e');
  }
  }
}