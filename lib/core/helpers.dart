import 'package:flash_chat/core/api/firebase_client.dart';
import 'package:flash_chat/core/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

typedef StringToVoidFunction = void Function(String);
class Helpers {
  static String? validateEmail (String? value) {
    const pattern  = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";

        RegExp regExp = RegExp(pattern);
        if(value!.isEmpty){
          return "Required Field";
        }
        else {
         if (regExp.hasMatch(value)) {
        return null;
        }
        }
        return "Invalid Email Address";
  }

  static String? validateFormField (String? value){
    if (value!.isEmpty){
      return "Required Field";
    } if (value.length < 3){
      return "Minimum field length is 3";
    }
  }

  static String? validatePassword(String? value,String? matchValue,bool isFromPasswordField) {
    if (value!.isEmpty) {
      return "Required field";
    }
    if (value.length < 3) {
      return "Minimum field length is 3";
    }

    if(isFromPasswordField && value != matchValue){
      return "Password do not match";
    }
  }

  static void showToast(BuildContext context, String msg) {
    print("msg " + msg);

    if (msg == null) {
      return;
    }
    ToastContext().init(context);
    Toast.show(msg,duration: Toast.lengthLong, gravity:  Toast.bottom);
    
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 37, 151, 136),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              padding: EdgeInsets.all(24.0),
              child: const CircularProgressIndicator(color: Colors.white,),
            ),
          ),
        ),
      )
        );
  }
  
  static void  hideProgressBar(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void handleGoogleSignIn(BuildContext context) {
      Helpers.showProgressBar(context);

      API.signInWithGoogle().then((user) async {
        Helpers.hideProgressBar(context);
        if (user != null) {
          if (await API.userExist()) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, AppRoutes.Dashboard_Screen);
          } else {
            await API.createUser().then((value) =>
                Navigator.pushReplacementNamed(
                    context, AppRoutes.Dashboard_Screen));
          }
        }
      }).catchError((error) {
        Helpers.hideProgressBar(context);
      });
    }

    static Future<void> image() async{      
      await API.getSelfInfo().whenComplete(() {        
           API.selfInfo.image!;
                
      });
      
    }

}