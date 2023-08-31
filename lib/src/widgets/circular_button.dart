import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  final Function onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            shape: BoxShape.rectangle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 1,
                color: Colors.grey.shade300,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: icon,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              splashColor: Colors.blueAccent.withOpacity(0.6),
              onTap: (() => onPressed()),
            ),
          ),
        ),
      ],
    );
  }
}
