import 'package:flash_chat/core/helpers.dart';
import 'package:flutter/material.dart';

class PasswordTextFormWidget extends StatefulWidget {
  String text;
  String passwordValue;
  bool fromPasswordField;
  TextEditingController controller;
  TextInputType inputType;
  StringToVoidFunction onChanged;
  TextInputAction action;
  IconData iconData;
    PasswordTextFormWidget({super.key,     
    required this.text,
    required this.controller,
    this.passwordValue = "",
    this.fromPasswordField = false,
    this.inputType = TextInputType.visiblePassword,
    required this.onChanged,
    this.action = TextInputAction.done,
    required this.iconData


  });

  @override
  State<PasswordTextFormWidget> createState() => _PasswordTextFormWidgetState();
}

class _PasswordTextFormWidgetState extends State<PasswordTextFormWidget> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {    
    return TweenAnimationBuilder(
      tween: Tween(begin: -50.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
      child: TextFormField(
      keyboardType: widget.inputType,
      controller: widget.controller,
      obscureText: !_passwordVisible,
      validator: (input) {
          return Helpers.validatePassword(input!, widget.passwordValue, widget.fromPasswordField);
        },
        onChanged: widget.onChanged,
      decoration: InputDecoration( 
      suffixIcon: IconButton(
        icon: Icon(
          _passwordVisible ? Icons.visibility : Icons.visibility_off, 
          color: Colors.grey,),
        onPressed: (){
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },),  
      prefixIcon: IconButton(
        icon: Icon(widget.iconData, color: Colors.grey,),
        onPressed: widget.fromPasswordField ? widget.action == TextInputAction.done ? null : (){} : (){},
    ),                     
      // ignore: prefer_interpolation_to_compose_strings
      hintText: 'Enter ' + widget.text,                
      contentPadding: const EdgeInsets.all(20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 37, 151, 136), width: 1.5),
        borderRadius: BorderRadius.circular(15.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      ),
      
      ),
    );
  }
}