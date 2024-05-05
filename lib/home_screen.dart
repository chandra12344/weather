import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/controller/weather_controller.dart';
import 'forecast_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherController controller=Get.put(WeatherController());
  late Timer _timer;
   var locationName='';
   var _currentTime='';



  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.isLoading.value=true;
    _timer = Timer.periodic(Duration(microseconds: 1), _updateTime);
    getLocation();
    Timer(Duration(seconds: 5), () {
      controller.isLoading.value=false;
    });

  }
  getLocation()async{
    getUserCurrentLocation().then((value) async {
      List<Placemark> list = await placemarkFromCoordinates(value.latitude, value.longitude);
     print("lat ${value.latitude} log ${value.longitude}");
      controller.getWeatherData(value.latitude,value.longitude,DateTime.now(),"1");
      print(list[0]);
      locationName=list[0].locality!;
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _updateTime(Timer timer) {
    setState(() {
      _currentTime = _getCurrentTime();
    });
  }

  String _getCurrentTime() {
    return DateFormat('hh:mm:ss a').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor:  Color(0xFF47BFDF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("${DateFormat('dd MMMM yyyy').format(DateTime.now())}",
        style: GoogleFonts.cabin(textStyle: const TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,fontSize: 16)),),
       backgroundColor:  Color(0xFF4A91FF),
      elevation: 10,
      actions: [
        Text("$_currentTime",
          style: GoogleFonts.cabin(textStyle: const TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,fontSize: 16)),),
        SizedBox(width: 20,)
      ],),
      body: Obx(
        ()=> Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF47BFDF),
                    Color(0xFF4A91FF),
                  ],
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                  transform: GradientRotation(192.05 * 3.14 / 180), // Convert degrees to radians
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(19, 35, 78, 0.2),
                    offset: Offset(-5, 10),
                    blurRadius: 40,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  TextButton.icon(onPressed: (){}, icon: const Icon(Icons.location_on_outlined,color: Colors.white,), label: Text(locationName,style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),)),
                  const SizedBox(height: 50,),
                  Center(
                    child:Lottie.asset('assets/lottie/splace.json',height: 120,width: 120),
                  ),
                  const SizedBox(height: 50,),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 327.28,
                      height: 310.59,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.3), // Background color with opacity
                        borderRadius: BorderRadius.circular(18.5429), // Border radius
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.transparent, // No shadow color
                            blurRadius: 2.31786, // Blur radius
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Today, ${DateFormat('dd MMMM').format(DateTime.now())}",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                          Obx(()=> Text("${controller.temp}°C",style: GoogleFonts.overpass(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 60)),)),
                          Text("Cloudy",style: GoogleFonts.overpass(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.wind_power,color: Colors.white,),
                            const SizedBox(width: 10,),
                            Text("Wind",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                            const SizedBox(width: 10,),
                            Text("|",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                            const SizedBox(width: 10,),
                            Obx(()=> Text("${controller.wind} km/h",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),)),

                          ],
                        ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.water_drop_outlined,color: Colors.white,),
                              const SizedBox(width: 10,),
                              Text("Hum",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                              const SizedBox(width: 10,),
                              Text("|",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                              const SizedBox(width: 10,),
                              Obx(()=> Text("${controller.hum} %",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),)),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                   Center(
                    child: Container(
                      width: 203.97,
                      height: 59.34,
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(-3.70857, 7.41714),
                            blurRadius: 46.3571,
                            spreadRadius: 3.70857,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(1.85429, -2.78143),
                            blurRadius: 5.56286,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.25),
                            offset: Offset(-5.56286, 3.70857),
                            blurRadius: 3.70857,
                            spreadRadius: 0,
                            // You can add more BoxShadow properties if needed
                          ),
                        ],
                        borderRadius: BorderRadius.circular(18.5429), // Border radius
                      ),
                    child: TextButton(onPressed: (){
                      Get.to(ForecastScreen());
                    },child: Text("Forecast report",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold)),),),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset("assets/images/line.png"),
           controller.isLoading.value? Container(
              color: Colors.black.withOpacity(0.8),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  ),
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/splace.json',height: 100,width: 100), // Loading indicator
                      const SizedBox(height: 16),
                      Text("Loading...",style: GoogleFonts.overpass(textStyle: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20)),),
                      // Optional text to show alongside the indicator
                    ],
                  ),
                ),
              ),
            ):SizedBox()
          ],
        ),
      ),
    );
  }

}
