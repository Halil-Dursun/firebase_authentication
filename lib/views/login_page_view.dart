import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_islemleri/controller/obsecure_text_controller.dart';
import 'package:firebase_islemleri/views/home_page_view.dart';
import 'package:firebase_islemleri/views/register_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  static const String loginPageRoute = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '', password = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ObscureText _controller = Get.put(ObscureText());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-mail adresinizi giriniz',
                        hintText: 'example@example.com',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (alinanMail) {
                        setState(() {
                          email = alinanMail;
                        });
                      },
                      validator: (alinanMail) {
                        if (alinanMail != null) {
                          return alinanMail.contains('@') &&
                                  alinanMail.length >= 6
                              ? null
                              : 'Mail adresiniz geçersiz';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _controller.obscureTextLogin.value,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _controller.changeObscureLogin();
                            },
                            child: _controller.obscureTextLogin.value
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          labelText: 'Şifrenizi Giriniz',
                          hintText: 'Example123.',
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (alinanPassword) {
                          setState(() {
                            password = alinanPassword;
                          });
                        },
                        validator: (alinanMail) {
                          if (alinanMail != null) {
                            return alinanMail.length >= 8
                                ? null
                                : 'Şifre 8 karekterden büyük olmalıdır.';
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    padding: EdgeInsets.all(12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: loginUser,
                      child: Text(
                        'Giriş Yap',
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(RegisterPage.registerPageRoute);
                      },
                      child: Text('Hesap Oluştur...')),
                ],
              ),
            ),
          ),
        ));
  }

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Fluttertoast.showToast(
            msg: "Giriş başarılı",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.offNamedUntil(HomePage.homePageRoute, (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg: "Kullanıcı bulunamadı",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
              msg: "Hatalı şifre girişi",
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
  }
}
