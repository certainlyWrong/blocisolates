import 'package:blocisolates/bloc.dart';
import 'package:blocisolates/events.dart';
import 'package:blocisolates/states.dart';

void main() async {
  final bloc = await Bloc.init();

  bloc.state.listen((state) {
    if (state is FibonacciState) {
      print('Fibonacci: ${state.number} => ${state.result}');
    } else if (state is PrimeState) {
      print('Prime: ${state.number} => ${state.isPrime}');
    } else if (state is SlowState) {
      print('Slow: ${state.number} => ${state.result}');
    }
  });

  bloc.event.add(FibonacciEvent(10));

  bloc.event.add(PrimeEvent(11));

  bloc.event.add(PrimeEvent(30));

  bloc.event.add(SlowEvent(12));

  bloc.event.add(FibonacciEvent(40));
  bloc.event.add(FibonacciEvent(40));
  bloc.event.add(FibonacciEvent(40));
  bloc.event.add(FibonacciEvent(40));

  bloc.event.add(PrimeEvent(13));

  bloc.event.add(SlowEvent(14));

  Future.delayed(Duration(seconds: 10), () {
    print('Closing bloc...');
    bloc.dispose();
  });
}
