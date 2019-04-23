import 'package:flutter/material.dart';
import 'package:flutterpoc/data/models.dart';

class CountingText extends StatelessWidget {
  CountingText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScopedModelDescendant<CounterModel>(
      builder: (context, child, model) {
        return Text(
          '${model.counter}',
          style: TextStyle(fontSize: 24.0),
        );
      },
    );
  }
}
