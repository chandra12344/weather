import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 45,
                          child: Image.asset(
                              "assets/images/javin_logo_80.png"), //CircleAvatar
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          "SG Encon Attendance App",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Username",
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),


                        TextFormField(
                          controller: password,
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
                          controller: username,
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
                      SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child:TextButton(
                              onPressed: () {
    if (_formKey.currentState!.validate()) {

    }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue, // Background Color
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:  Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ),
                            )
                          ),
                       
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

