import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  CounterState get initialState => CountingState(0);

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is IncrementEvent) {
      yield* _mapIncrementEventToState();
    } else if (event is DecrementEvent) {
      yield* _mapDecrementEventState(event);
    }
  }

  Stream<CountingState> _mapIncrementEventToState() async* {
    yield CountingState((currentState as CountingState).counter + 1);
  }

  Stream<CountingState> _mapDecrementEventState(DecrementEvent event) async* {
    yield CountingState((currentState as CountingState).counter - 1);
  }
}
