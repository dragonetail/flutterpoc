import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState>
    extends Bloc<Event, State> {
  //Event到State映射函数表
  Map<Type, Function(Event)> get mapper;

  @override
  Stream<State> mapEventToState(
    Event event,
  ) async* {
    if (mapper == null) {
      return;
    }
    Type type = event.runtimeType;
    var function = mapper[type];
    if (function == null) {
      return;
    }
    yield* function(event);
  }
}

@immutable
abstract class BaseEvent extends Equatable {
  BaseEvent([List props = const []]) : super(props);
}

@immutable
abstract class BaseState extends Equatable {
  BaseState([List props = const []]) : super(props);
}
