import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_islemleri/controller/obsecure_text_controller.dart';
import 'package:firebase_islemleri/views/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  static const String registerPageRoute = '/RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '', password = '';
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  ObscureText _contoller = Get.put(ObscureText());
  GlobalKey<FormState> _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register Page'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formAnahtari,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'Register',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        obscureText: _contoller.obscureTextRegister.value,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _contoller.changeObscureRegister();
                              debugPrint(_contoller.obscureTextRegister.value
                                  .toString());
                            },
                            child: _contoller.obscureTextRegister.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          labelText: 'Şifrenizi Giriniz',
                          hintText: 'Example123.',
                          border: OutlineInputBorder(),
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
                        primary: Colors.red,
                      ),
                      onPressed: registerUser,
                      child: Text(
                        'Kayıt Ol',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void registerUser() async {
    if (_formAnahtari.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Fluttertoast.showToast(
            msg: "Kayıt başarılı",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.offNamedUntil(HomePage.homePageRoute, (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
              msg: "Basit şifre",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "Bu mail adresine ait hesap bulunmakta",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      } catch (e) {
        print(e);
        Fluttertoast.showToast(
            msg: "Beklenmeyen bir hata oluştu",
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
