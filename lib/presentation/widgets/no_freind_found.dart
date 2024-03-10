import 'package:flutter/material.dart';

class NoFreindFound extends StatelessWidget {
  VoidCallback onClick;
  NoFreindFound({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/error.png',
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("No friends availabe to chat", 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          const SizedBox(
            height: 10,
          ),
          const Text("Search for a friend",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),),
          const SizedBox(height: 20,),
          ElevatedButton(
        style: ElevatedButton.styleFrom(
            surfaceTintColor: const Color.fromARGB(255, 37, 151, 136),
            backgroundColor: const Color.fromARGB(255, 37, 151, 136),
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0))),
        // ignore: sort_child_properties_last
        child: const SizedBox(
          height: 60,
          width: double.infinity,
          child: Center(
              child: Text(
              "Add Friend",
            style: TextStyle(fontSize: 20),
          )),
        ),
        onPressed: onClick
      ),
        ],
      ),
    );
  }
}