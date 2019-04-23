import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaddingFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  PaddingFloatingActionButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: FloatingActionButton(
        child: Icon(icon),
        onPressed: () => onPressed(),
        heroTag: icon.codePoint,
      ),
    );
  }
}
