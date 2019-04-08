# APP启动页（Splash Page）



**说明：** 本部分完成部分在分支： <https://github.com/dragonetail/flutterpoc/tree/3-splash_page>

**目标：** 涉及Flutter的Router和Splash Page工作原理，全程使用Bloc模式。



1. Flutter的页面路由：

   ```dart
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
   ```

   对mapEventToState进行了默认实现，根据`Map<Type, Function(Event)> get mapper`定义的【Event到State映射函数表】进行业务逻辑函数的dispatch操作，简化业务逻辑的if级联判断。

2. 再看看counter_bloc.dart的实现：

   ```dart
   import 'dart:async';
   import '../blocs.dart';
   
   class CounterBloc extends BaseBloc<CounterEvent, CounterState> {
     @override
     CounterState get initialState => CountingState(0);
   
     @override
     Map<Type, Function(CounterEvent)> get mapper => {
           IncrementEvent: _mapIncrementEventToState,
           DecrementEvent: _mapDecrementEventToState,
         };
   
     Stream<CounterState> _mapIncrementEventToState(CounterEvent event) async* {
       yield CountingState((currentState as CountingState).counter + 1);
     }
   
     Stream<CounterState> _mapDecrementEventToState(CounterEvent event) async* {
       yield CountingState((currentState as CountingState).counter - 1);
     }
   }
   
   //Event定义
   abstract class CounterEvent extends BaseEvent{
     CounterEvent([List props = const []]) : super(props);
   }
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
   ```

   通过重载`Map<Type, Function(CounterEvent)> get mapper => {`定义了两个Event类到对应处理方法的映射表。

   统一映射方法的处理，接受`CounterEvent event`，返回`Stream<CounterState>`。

   同时简化Event和State的定义，整个所有Bloc相关的内容都放到一个文件中，减少文件拆分，简化工程化开发的复杂度。

   【研讨】在这个抽取过程中，通过BaseEvent、BaseState的抽取，技术上应该不需要CounterEvent、CounterState进行过渡，直接在映射方法的参数和返回值上使用BaseEvent、BaseState，是不是会更好？

   

3. 结论： 整体上，这样基本对于业务逻辑拆分隔离来说，复杂度已经降低到类似Spring框架的水平附近了。

   

