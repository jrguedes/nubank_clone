import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  final Widget child;

  const CardHome({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
}
