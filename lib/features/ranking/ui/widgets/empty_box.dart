import 'package:flutter/material.dart';

/// EmptyBox is a StatelessWidget that displays an empty box image.
class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/empty_box.png',
      width: 150,
      height: 150,
    );
  }
}
