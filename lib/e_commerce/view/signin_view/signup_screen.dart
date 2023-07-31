import 'package:e_commerce_admin/e_commerce/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              Text("SignUp",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 100),
              TextField(
                controller: txtEmail,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.person_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: txtPassword,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text("Password"),
                    prefixIcon: Icon(Icons.security_rounded),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  String msg= await FirebaseHelper.helper.createUser(txtEmail.text, txtPassword.text);
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
                    child: Center(child: Text("SignUp",style: TextStyle(color: Colors.white),))),
              ),
              SizedBox(height: 40),
              InkWell(
                  onTap: () {

                    Get.toNamed('/signin');
                  },
                  child: Text("Already have account ",style: TextStyle(color: Colors.black),)),
            ],
          ),
        ),
      ),
    );
  }
}
