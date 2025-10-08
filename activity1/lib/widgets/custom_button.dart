import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool useCupertino;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.useCupertino = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useCupertino) {
      return CupertinoButton.filled(onPressed: onPressed, child: Text(label));
    }
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
