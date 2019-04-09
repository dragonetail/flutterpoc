import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpoc/blocs/index.dart';
import 'package:flutterpoc/common/index.dart';

class CountingText extends StatelessWidget {
  CountingText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

    return BlocBuilder<BaseEvent, BaseState>(
      bloc: _counterBloc,
      builder: (BuildContext context, BaseState baseState) {
        return Text(
          '${(baseState as CountingState).counter}',
          style: TextStyle(fontSize: 24.0),
        );
      },
    );
  }
}
