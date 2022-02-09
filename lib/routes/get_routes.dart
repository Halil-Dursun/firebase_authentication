

import 'package:firebase_islemleri/views/home_page_view.dart';
import 'package:firebase_islemleri/views/login_page_view.dart';
import 'package:firebase_islemleri/views/register_page_view.dart';
import 'package:get/get.dart';

List<GetPage> getRoutes = [
  GetPage(name: HomePage.homePageRoute, page: () => HomePage()),
  GetPage(name: RegisterPage.registerPageRoute, page: () => RegisterPage()),
  GetPage(name: LoginPage.loginPageRoute, page: () => LoginPage()),
];