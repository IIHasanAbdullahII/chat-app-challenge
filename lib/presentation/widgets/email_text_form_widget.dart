import 'package:flutter/material.dart';

import '../../core/helpers.dart';

class EmailTextFormWidget extends StatefulWidget {
  String text;
  IconData iconData;
  TextInputType inputType;
  TextEditingController controller;
  EmailTextFormWidget({super.key, 
    required this.text,
    required this.controller,
    required this.iconData,
    this.inputType = TextInputType.emailAddress
  });

  @override
  State<EmailTextFormWidget> createState() => _EmailTextFormWidgetState();
}

class _EmailTextFormWidgetState extends State<EmailTextFormWidget> {
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
      textInputAction: TextInputAction.next,
      controller: widget.controller,
      validator: (input) {
          return Helpers.validateEmail(input!);
        },
      onFieldSubmitted: (_) {
       FocusScope.of(context).nextFocus();
      },
      decoration: InputDecoration(     
        prefixIcon: IconButton(
        icon: Icon(widget.iconData, color: Colors.grey,),
        onPressed: () {
          
        },),           
      // ignore: prefer_interpolation_to_compose_strings
      hintText: 'Enter ' + widget.text,                
      contentPadding:
          const EdgeInsets.all(20.0),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 37, 151, 136), width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      ),
      
      ),
    );
  }
}
