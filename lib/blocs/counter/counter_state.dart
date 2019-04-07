import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CounterState extends Equatable {
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
