import 'package:flutter/cupertino.dart';

class CircularBox extends StatelessWidget {
  Widget widget;

  CircularBox({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0XFF121312)),
      child: widget,
    );
  }
}
