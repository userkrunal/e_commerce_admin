import 'package:e_commerce_admin/e_commerce/controller/firebase_controller.dart';
import 'package:e_commerce_admin/e_commerce/helper/firebase_helper.dart';
import 'package:e_commerce_admin/e_commerce/model/firebase_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  FirbaseController controller = Get.put(FirbaseController());


  TextEditingController txtName=TextEditingController();
  TextEditingController txtPrice=TextEditingController();
  TextEditingController txtCategory=TextEditingController();
  TextEditingController txtDescription=TextEditingController();
  TextEditingController txtImg=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leading: Icon(Icons.add_box_outlined),title: Text("Add Product"),centerTitle: true,backgroundColor: Color(0xff9B99F5)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                TextField(
                  controller: txtName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Product Name"),

                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: txtPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Product Price"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: txtCategory,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Product Category"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: txtDescription,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      label: Text("Product Description"),

                ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: txtImg,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: Text("Product Image"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    ProductModel m1=ProductModel(
                      img: txtImg.text,
                      category: txtCategory.text,
                      name: txtName.text,
                      price: txtPrice.text,
                      description: txtDescription.text,);
                    FirebaseHelper.helper.addproduct(m1);
                    controller.i.value=0;
                    Get.back();

                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xff9B99F5)),
                    child: Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold))),
                  ),
                )
              ],
            ),
          ),
      ),
      ),
    );
  }
}
