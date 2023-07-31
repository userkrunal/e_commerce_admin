import 'package:e_commerce_admin/e_commerce/view/signin_view/add_product.dart';
import 'package:e_commerce_admin/e_commerce/view/signin_view/home_screen.dart';
import 'package:e_commerce_admin/e_commerce/view/signin_view/signin_screen.dart';
import 'package:e_commerce_admin/e_commerce/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'e_commerce/view/signin_view/signup_screen.dart';
import 'firebase_options.dart';

// Future<void> main()
// async {
//
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/':(p0) =>SplashScreen(),
//       },
//     )
//  );
//}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {'/': (context) => SplashScreen(),
          '/signin':(context) =>SignInScreen(),
          '/signup':(context) =>SignUpScreen(),
          '/home':(context) =>HomeScreen(),
          '/add':(context) =>AddProduct(),
        },
      );
    },)
  );
}
