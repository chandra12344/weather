import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/constants.dart';
import 'package:http/http.dart' as http;

import '../models/weather_data.dart';

class WeatherController extends GetxController{
  var dateList=[];
  List<WeatherData> dataList=[];
  var isLoading=false.obs;
  var isLoading2=false.obs;
  var temp=''.obs;
  var hum=''.obs;
  var wind=''.obs;

  getWeatherData(lat,lon,date,type)async{
    int unixTimestamp = date.millisecondsSinceEpoch ~/ 1000;
    type=="1"?isLoading.value:isLoading2.value=true;
    String city = '';
    // String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$API_KEY';
    String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&dt=$unixTimestamp&appid=$API_KEY';
  try{
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var weather = data['weather'][0]['main'];
      if(type=="1"){
        temp.value="${(data['main']['temp'] - 273.15).toStringAsFixed(1)}";
        hum.value="${data['main']['humidity']}";
        wind.value="${data['wind']['speed']}";
      }else{
        WeatherData weatherData = WeatherData(date: date,
            temp: "${(data['main']['temp'] - 273.15).toStringAsFixed(1)}",
            wind: "${data['wind']['speed']}",
            hum: "${data['main']['humidity']}");
        dataList.add(weatherData);
      }
      print('Weather: $weather');
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
    type=="1"?isLoading.value:isLoading2.value=false;
  }catch(e){
    type=="1"?isLoading.value:isLoading2.value=false;
    debugPrint('Error: $e');
  }
  }


  void saveBulkData(List<WeatherData> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonData = data.map((user) => user.toJson()).toList();
    prefs.setString('bulkData', jsonEncode(jsonData));
  }

  Future<List<WeatherData>> getBulkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('bulkData');
    if (jsonString != null) {
      List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((json) => WeatherData.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  getAllDate(lat,lon){
    var check=false.obs;
    dateList.clear();
    DateTime currentDate = DateTime.now();
    dateList.add(currentDate);
    for(int i=1;i<=15;i++){
      DateTime dateDaysAgo = currentDate.subtract(Duration(days: i));
      dateList.add(dateDaysAgo);
      for(int i=0;i<dataList.length;i++){
        if(dataList[i].date==dateDaysAgo){
          check.value=true;
          return;
        }
      }
      if(!check.value){
      getWeatherData(lat,lon,dateDaysAgo,"2");
      }
    }
    saveBulkData(dataList);
  }
}