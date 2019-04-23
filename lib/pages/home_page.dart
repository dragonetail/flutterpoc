import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterpoc/widgets/index.dart';
import 'package:flutterpoc/data/models.dart';
import './app_drawer_page.dart';

class HomePage extends StatefulWidget {
  final String title = '首页';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CounterModel _counter = CounterModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: _counter,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.pushNamed(context, '/settings'),
            )
          ],
        ),
        drawer: AppDrawerPage(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              CountingText(),
            ],
          ),
        ),
        floatingActionButton: ScopedModelDescendant<CounterModel>(
          builder: (context, child, model) => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  PaddingFloatingActionButton(
                    icon: Icons.add,
                    onPressed: () => model.increment(),
                  ),
                  PaddingFloatingActionButton(
                    icon: Icons.remove,
                    onPressed: () => model.decrement(),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
