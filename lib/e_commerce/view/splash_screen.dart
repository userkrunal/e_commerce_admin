import 'dart:async';

import 'package:e_commerce_admin/e_commerce/controller/firebase_controller.dart';
import 'package:e_commerce_admin/e_commerce/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirbaseController controller=Get.put(FirbaseController());

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Get.toNamed(FirebaseHelper.helper.auth.currentUser==null?'/signin':'/home');
    });

    return SafeArea(child: Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage("assets/images/img.png"),fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("We Design ",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
              Text("Furniture For  ",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
              Text("Your Comfort  ",style: TextStyle(fontSize: 35,color: Colors.white,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    ));
  }
}
