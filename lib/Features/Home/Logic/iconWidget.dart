import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;


  const CustomIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Theme.of(context).colorScheme.secondary,
      size: 25,
    );
  }
}
