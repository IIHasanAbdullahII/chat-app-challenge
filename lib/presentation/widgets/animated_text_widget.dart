import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  String text;
  VoidCallback onClick;
  Color color;
  AnimatedText({
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
      child: InkWell(
        onTap: onClick,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color
          ),
        )),
      ),
    );
  }
}