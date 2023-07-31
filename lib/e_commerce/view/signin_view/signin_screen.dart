import 'package:e_commerce_admin/e_commerce/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtEmail=TextEditingController();
  TextEditingController txtPassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: txtEmail,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                ),
              ),
              SizedBox(height: 20),
              TextField (
                controller: txtPassword,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.security_rounded),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                ),
              ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                String msg= await FirebaseHelper.helper.signIn(txtEmail.text, txtPassword.text);
                if(msg=='succes')
                  {
                    Get.offAllNamed('/home');
                  }
                Get.snackbar('$msg', '',backgroundColor: msg=='succes'?Colors.green:Colors.red);
              },
              child: Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.purpleAccent.shade100),
                  child: Center(child: Text("Signin",style: TextStyle(color: Colors.white),))),
            ),
              SizedBox(height: 40),
              InkWell(
                  onTap: () {

                    Get.toNamed('/signup');
                  },
                  child: Text("Creat a new new account! ",style: TextStyle(color: Colors.black),)),

            ],
          ),
        ),
      ),
    );
  }
}
