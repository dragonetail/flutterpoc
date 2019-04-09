import 'dart:async';
import 'package:flutterpoc/common/index.dart';

class CounterBloc extends BaseBloc<BaseEvent, BaseState> {
  @override
  BaseState get initialState => CountingState(0);

  @override
  Map<Type, Function(BaseEvent)> get mapper => {
        IncrementEvent: _mapIncrementEventToState,
        DecrementEvent: _mapDecrementEventToState,
      };

  Stream<BaseState> _mapIncrementEventToState(BaseEvent event) async* {
    yield CountingState((currentState as CountingState).counter + 1);
  }

  Stream<BaseState> _mapDecrementEventToState(BaseEvent event) async* {
    yield CountingState((currentState as CountingState).counter - 1);
  }
}

//Event定义
class IncrementEvent extends BaseEvent{}
class DecrementEvent extends BaseEvent{}

//State定义
class CountingState extends BaseState {
  final int counter;

  CountingState(this.counter) : super([counter]);

  @override
  String toString() {
    return 'CountingState { counter: $counter }';
  }
}