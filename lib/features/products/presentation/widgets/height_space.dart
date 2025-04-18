import 'package:flutter/material.dart';

class HeightSpace extends StatelessWidget {
  final double value;
  const HeightSpace(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value);
  }
}
