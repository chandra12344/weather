import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/controller/weather_controller.dart';
class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  WeatherController controller=Get.put(WeatherController());



@override
  void initState() {

    super.initState();
    getData();
    controller.isLoading2.value=true;
    Timer(Duration(seconds: 5), () {
      controller.isLoading2.value=false;
      setState(() {
        
      });
    });
  }
  getData()async{

    controller.dataList=await controller.getBulkData();

    getUserCurrentLocation().then((value) async {
      print("lat ${value.latitude} log ${value.longitude}");
      controller.getAllDate(value.latitude,value.longitude);
    });
  }
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF47BFDF),
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back,color: Colors.white,),),
        title: Text("Forecast report",
          style: GoogleFonts.cabin(textStyle: const TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,fontSize: 16)),),
        backgroundColor:  Color(0xFF4A91FF),
        elevation: 10,),
      body: Stack(
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
              child: ListView.builder(
                  itemCount: controller.dataList.length,
                  itemBuilder: (context,index){
                return Container(child: Column(
                  children: [
                    Text("${DateFormat('dd MMMM').format(controller.dataList[index].date)}",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.timeline_rounded,color: Colors.white,),
                        const SizedBox(width: 10,),
                        Text("temp",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                        const SizedBox(width: 10,),
                        Text("|",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                        const SizedBox(width: 10,),
                     Text("${controller.dataList[index].temp} km/h",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),

                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wind_power,color: Colors.white,),
                        const SizedBox(width: 10,),
                        Text("Wind",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                        const SizedBox(width: 10,),
                        Text("|",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                        const SizedBox(width: 10,),
                       Text("${controller.dataList[index].wind} km/h",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),

                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.water_drop_outlined,color: Colors.white,),
                        const SizedBox(width: 10,),
                        Text("humidity",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                        const SizedBox(width: 10,),
                        Text("|",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),
                        const SizedBox(width: 10,),
                Text("${controller.dataList[index].hum} km/h",style: GoogleFonts.raleway(textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),),

                      ],
                    ),
                    Divider(),
                    SizedBox(height: 10,)
                  ],
                ));
              })
            ),
            Image.asset("assets/images/line.png"),
            Obx(() => controller.isLoading2.value? Container(
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
            ):SizedBox())

          ],
        ),
    );
  }

}
