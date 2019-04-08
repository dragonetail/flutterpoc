import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpoc/blocs/blocs.dart';
import 'package:flutterpoc/widgets/widgets.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key key}) : super(key: key);

  final String title = 'Flutter Demo Home Page';

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final CounterBloc _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocProvider<CounterBloc>(
              bloc: _counterBloc,
              child: CountingText(),
            )
          ],
        ),
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
