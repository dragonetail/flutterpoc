import 'package:stack_trace/stack_trace.dart';

foo() async{
    await 'asynchronous wait';
    throw 'error';
}
bar() => foo();
gee() => bar();
main(){
    Chain.capture(gee, onError: (e, chain){
        print(chain.terse);
    });
}
