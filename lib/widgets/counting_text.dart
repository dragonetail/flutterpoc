import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpoc/blocs/blocs.dart';

class CountingText extends StatelessWidget {
  CountingText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

    return BlocBuilder<CounterEvent, CounterState>(
      bloc: _counterBloc,
      builder: (BuildContext context, CounterState counterState) {
        return Text(
          '${(counterState as CountingState).counter}',
          style: TextStyle(fontSize: 24.0),
        );
      },
    );
  }
}
