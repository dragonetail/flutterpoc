import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CounterEvent extends Equatable {
  CounterEvent([List props = const []]) : super(props);
}

class IncrementEvent extends CounterEvent {
  IncrementEvent() : super();

  @override
  String toString() => 'IncrementEvent';
}

class DecrementEvent extends CounterEvent {
  DecrementEvent() : super();

  @override
  String toString() => 'DecrementEvent ';
}
