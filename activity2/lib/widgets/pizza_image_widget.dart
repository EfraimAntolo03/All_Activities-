import 'package:flutter/material.dart';

class PizzaImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;
  final bool showShadow;

  const PizzaImageWidget({
    super.key,
    required this.imagePath,
    this.width = 80,
    this.height = 80,
    this.borderRadius = 12,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Icon(
                Icons.restaurant,
                color: Colors.grey,
                size: width * 0.4,
              ),
            );
          },
        ),
      ),
    );
  }
}
