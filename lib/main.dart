import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_islemleri/routes/get_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_page_view.dart';
import 'views/login_page_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialize = Firebase.initializeApp();
  late User? _user;
  late bool _isCurrent;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      getPages: getRoutes,
      home: FutureBuilder(
          future: _initialize,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Hata Oluştu'),
              );
            } else if (snapshot.hasData) {
              _user = FirebaseAuth.instance.currentUser;
              if (_user != null) {
                _isCurrent = true;
              } else {
                _isCurrent = false;
              }
              return _isCurrent ? HomePage() : LoginPage();
            } else {
              return const CircularProgressIndicator();
            }
          }),
      debugShowCheckedModeBanner: false,
    );
  }
}
