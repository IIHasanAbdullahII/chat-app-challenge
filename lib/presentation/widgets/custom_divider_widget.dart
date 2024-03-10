import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 50.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
      child: Row(
        children: [
          Expanded(
            child: Divider(
              height: 36.0,
              color: Colors.grey[500],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "OR",
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 36.0,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}