import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpoc/blocs/blocs.dart';
import 'package:flutterpoc/widgets/widgets.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      body: BlocBuilder<CounterEvent, CounterState>(
        bloc: _counterBloc,
        builder: (BuildContext context, CounterState counterState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${(counterState as CountingState).counter}',
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          PaddingFloatingActionButton(
            icon: Icons.add,
            onPressed: () => _counterBloc.dispatch(IncrementEvent()),
          ),
          PaddingFloatingActionButton(
            icon: Icons.remove,
            onPressed: () => _counterBloc.dispatch(DecrementEvent()),
          )
        ],
      ),
    );
  }
}
