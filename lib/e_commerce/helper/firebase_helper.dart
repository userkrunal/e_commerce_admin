import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/e_commerce/model/firebase_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper{
  static FirebaseHelper helper=FirebaseHelper._();
  FirebaseHelper._();
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firestore=FirebaseFirestore.instance;

  Future<String> createUser(String email,String password)
  async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return "succes";
    }
    catch(e){
      return "$e";
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "succes";
    } catch (e) {
      return "$e";
    }
  }

  bool chakuser() {
    User? user = auth.currentUser;
    return user != null;
  }
  Future<void> signOut()
  async {
    await auth.signOut();
  }

  Map<String, String?> userditailes() {
    User? user = auth.currentUser;
    var email = user!.email;
    var name = user.displayName;
    var number = user.phoneNumber;
    var photo = user.photoURL;
    return {"email": email, "name": name, "number": number, "photo": photo};
  }
  // -**********************************************************************-

  void addproduct(ProductModel model) {
    firestore.collection("Product").add({
      "image":model.img,
      "name": model.name,
      "price": model.price,
      "category": model.category,
      "description": model.description,

    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readProduct() {
    return firestore.collection("Product").snapshots();
  }

  void deleteData(String id) {
    firestore.collection("Product").doc("${id}").delete();
  }

  // void updateData(ProductModel model) {
  //   firestore.collection("Product").doc(model.id).set({
  //     "name": model.name,
  //     "description": model.description,
  //     "category": model.category,
  //     "price": model.price,
  //     "image": model.img
  //   });
  // }





}


