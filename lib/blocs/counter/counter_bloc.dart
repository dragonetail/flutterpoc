import 'dart:async';
import '../blocs.dart';

class CounterBloc extends BaseBloc<CounterEvent, CounterState> {
  @override
  CounterState get initialState => CountingState(0);

  @override
  Map<Type, Function(CounterEvent)> get mapper => {
        IncrementEvent: _mapIncrementEventToState,
        DecrementEvent: _mapDecrementEventState,
      };

  Stream<CounterState> _mapIncrementEventToState(CounterEvent event) async* {
    yield CountingState((currentState as CountingState).counter + 1);
  }

  Stream<CounterState> _mapDecrementEventState(CounterEvent event) async* {
    yield CountingState((currentState as CountingState).counter - 1);
  }
}


 
//Event定义
abstract class CounterEvent extends BaseEvent{}
class IncrementEvent extends CounterEvent{}
class DecrementEvent extends CounterEvent{}

//State定义
abstract class CounterState extends BaseState{
  CounterState([List props = const []]) : super(props);
}
class CountingState extends CounterState {
  final int counter;

  CountingState(this.counter) : super([counter]);

  @override
  String toString() {
    return 'CountingState { counter: $counter }';
  }
}