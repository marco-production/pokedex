import 'package:flutter/material.dart';

class TypeContainer extends StatelessWidget {
  const TypeContainer(this.type, {super.key});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(child: Text(type, style: const TextStyle(color: Colors.white, fontSize: 18))),
    );
  }
}