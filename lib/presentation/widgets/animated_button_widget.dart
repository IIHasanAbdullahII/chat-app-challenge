import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  String text;
  VoidCallback onClick;
  Color color;
  AnimatedButton({
    super.key,
    required this.text,
    required this.onClick,
    this.color = const Color.fromARGB(255, 37, 151, 136),    
  }); 

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: const Offset(0.0, 1.0), end: const Offset(0,0)),
      duration: const Duration(milliseconds: 1500),
      builder: (BuildContext context, Offset offset, Widget? child) {
        return Transform.translate(
          offset: offset * 50, 
          child: child,
        );
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            surfaceTintColor: color,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0))),
        // ignore: sort_child_properties_last
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: Center(
              child: Text(
              text,
            style: const TextStyle(fontSize: 20),
          )),
        ),
        onPressed: onClick
      ),
    );
  }
}