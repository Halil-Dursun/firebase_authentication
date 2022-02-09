import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'login_page_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  static const String homePageRoute = '/HomePage';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            logOut();
          }, icon: Icon(Icons.logout),),
        ],
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: Text('${_user!.email}'),
            subtitle: Text(_user!.uid),
          ),
        ),
      ),
    );
  }

  void logOut() {
    try{
      _firebaseAuth.signOut();
      Fluttertoast.showToast(
          msg: "Çıkış yapıldı",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Get.offNamedUntil(LoginPage.loginPageRoute, (route) => false);
    }catch(e){
      print('bir hata olştu $e');
      Fluttertoast.showToast(
          msg: "Bir hata oluştu",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
