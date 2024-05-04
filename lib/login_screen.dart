import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue[50]?.withOpacity(0.1),
          child:Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Lottie.asset('assets/lottie/login.json',height: 160,width: 160,fit: BoxFit.cover,)),
               const SizedBox(height: 10,),
                 Center(
                   child: Text(
                    "Hello Again!",
                    style:GoogleFonts.hammersmithOne(textStyle: const TextStyle(color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.bold)),
                     textAlign: TextAlign.center,
                ),
                 ),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    "Welcome back you've been missed!",
                    style:GoogleFonts.cairo(textStyle: const TextStyle(color: Colors.black, fontSize: 16.0)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const Text(
                  "Username",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    // Adjust content padding here
                    hintText: 'Enter Username',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Username';
                    }
                    // You can add more password validation logic here if needed
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Password",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: visible,
                  controller: password,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    // Adjust content padding here
                    hintText: 'Enter Password',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(icon: Icon(!visible?Icons.visibility:Icons.visibility_off),onPressed: (){
                      setState(() {
                        visible = !visible;
                      });
                    },)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Password';
                    }
                    // You can add more password validation logic here if needed
                    return null;
                  },
                ),
                const SizedBox(
                  height: 26.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if(username.text!="admin"){
                          showError(context, "Please Enter valid username");
                        }else if(password.text!="admin@123"){
                          showError(context, "Please Enter valid password");
                        }else{
                         Get.to(const HomeScreen());
                        }
                      }
                    },
                    child:  Padding(
                      padding: const EdgeInsets.all(2.0),
                      child:  Text(
                        'Login',
                        style: GoogleFonts.hammersmithOne(textStyle:const TextStyle(
                            fontSize: 18.0, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  showError(context,msg){
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("$msg",style: const TextStyle(fontSize: 16,color: Colors.white),),backgroundColor: Colors.red,));
  }
}

