class WeatherData {
  WeatherData({
    required this.date,
    required this.temp,
    required this.wind,
    required this.hum,
  });
  late final DateTime date;
  late final String temp;
  late final String wind;
  late final String hum;

  WeatherData.fromJson(Map<String, dynamic> json){
    date = json['date'];
    temp = json['temp'];
    wind = json['wind'];
    hum = json['hum'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['temp'] = temp;
    _data['wind'] = wind;
    _data['hum'] = hum;
    return _data;
  }
}