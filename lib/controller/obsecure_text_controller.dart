

import 'package:get/get.dart';

class ObscureText extends GetxController{
  RxBool obscureTextLogin = true.obs;
  RxBool obscureTextRegister = true.obs;

  void changeObscureLogin(){
    obscureTextLogin.value = !obscureTextLogin.value;
  }
  void changeObscureRegister(){
    obscureTextRegister.value = !obscureTextRegister.value;
  }
}