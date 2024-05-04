import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/home_screen.dart';
import 'package:weather/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
bool isLogin=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    Timer(const Duration(seconds: 5), () {
      Get.off(
          isLogin?HomeScreen(): const LoginScreen()
      );
    });

  }

  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin= prefs.getBool("isLogin")??false;
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Lottie.asset('assets/lottie/splace.json',height: 300,width: 300),
      )
    );
  }
}
