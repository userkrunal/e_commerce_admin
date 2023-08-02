import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/e_commerce/controller/firebase_controller.dart';
import 'package:e_commerce_admin/e_commerce/helper/firebase_helper.dart';
import 'package:e_commerce_admin/e_commerce/model/firebase_model.dart';
import 'package:e_commerce_admin/e_commerce/view/signin_view/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirbaseController controller = Get.put(FirbaseController());

  @override
  void initState() {
    super.initState();
    controller.userditails.value = FirebaseHelper.helper.userditailes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff9B99F5),
              title: Text("Home Screen"),
              centerTitle: true,
            ),
            body: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseHelper.helper.readProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      QuerySnapshot qs = snapshot.data!;
                      List<QueryDocumentSnapshot> qList = qs.docs;

                      Map m1 = {};
                      List<ProductModel> productList = [];

                      for (var x in qList) {
                        m1 = x.data() as Map;
                        String id = x.id;
                        String name = m1['name'];
                        String category = m1['category'];
                        String price = m1['price'];
                        String image = m1['image'];
                        String description = m1['description'];
                        ProductModel model = ProductModel(
                            price: price,
                            name: name,
                            category: category,
                            description: description,
                            id: id,
                            img: image);
                        productList.add(model);
                      }

                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 228),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 320,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xffEDEDED)),
                                child: Column(

                                  children: [
                                    Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                                 // mainAxisSize: MainAxisSize.min,
                                  children: [
                                        IconButton(onPressed:  () {
                                          FirebaseHelper.helper.deleteData("${productList[index].id}");
                                        }, icon: Icon(Icons.delete)),
                                        IconButton(onPressed:  () {
                                          Get.toNamed('/update',arguments: productList[index]);
                                        }, icon: Icon(Icons.edit)),
                                      ],
                                    ),

                                    Container(
                                      height: 110,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(productList[
                                                              index]
                                                          .img !=
                                                      null
                                                  ? "${productList[index].img}"
                                                  : "https://m.media-amazon.com/images/I/71lG7br7k1L._SX679_.jpg"),
                                              fit: BoxFit.fill)),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "${productList[index].name}",
                                      style: TextStyle(
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "\$ ${productList[index].price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: productList.length,
                        ),
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 8.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff1C1C25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => IconButton(
                              onPressed: () {
                                controller.i.value = 0;
                              },
                              icon: Icon(
                                Icons.home_outlined,
                                size: 35,
                              ),
                              color: controller.i == 0
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                          Obx(
                            () => IconButton(
                              onPressed: () {
                                controller.i.value = 1;
                                Get.toNamed('/add');
                              },
                              icon: Icon(
                                Icons.add_circle_outline_outlined,
                                size: 35,
                              ),
                              color: controller.i == 1
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10)
              ],
            ),drawer: Drawer(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(controller.userditails['photo'] ==
                null
                ? "https://cdn-icons-png.flaticon.com/128/4140/4140048.png"
                : "${controller.userditails['pohto']}"),
            radius: 50,
          ),
          SizedBox(height: 20),
          Text(
            controller.userditails['email'] != null
                ? "${controller.userditails['email']}"
                : "",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 10),
          Text(
              controller.userditails['name'] != null
                  ? "${controller.userditails['name']}"
                  : "",
              style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text(
              controller.userditails['number'] != null
                  ? "${controller.userditails['number']}"
                  : "",
              style: TextStyle(fontSize: 18)),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await FirebaseHelper.helper.signOut();
                  Get.offAllNamed('/sing');
                },
                child: Container(
                  height: 60,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.indigo.shade100),
                  child: Center(
                      child: Text("Singout",
                          style: TextStyle(
                              fontSize: 20, color: Colors.white))),
                ),
              )
            ],
          )
        ],
      ),
    ),
    )));
  }
}

// Row(
//   mainAxisAlignment:
//       MainAxisAlignment.spaceAround,
//   children: [
//     Text(
//       "\$ ${productList[index].price}",
//       style: TextStyle(
//           fontWeight: FontWeight.w500,
//           fontSize: 16,
//           color: Colors.blue),
//     ),
//     Text(
//       "${productList[index].category}",
//       style: TextStyle(
//           fontWeight: FontWeight.w300,
//           fontSize: 15),
//     ),
//   ],
// ),
// Row(
//   mainAxisAlignment:
//       MainAxisAlignment.spaceAround,
//   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     IconButton(
//         onPressed: () {
//           // print(productList[index].id);
//           FirebaseHelper.helper.deleteData(
//               "${productList[index].id}");
//         },
//         icon: Icon(
//           Icons.delete,
//           size: 20,
//         )),
//     IconButton(
//         onPressed: () {
//           Get.toNamed('/update',
//               arguments:
//                   productList[index]);
//         },
//         icon: Icon(
//           Icons.edit,
//           size: 20,
//         )),
//   ],
// ),