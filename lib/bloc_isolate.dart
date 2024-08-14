import 'dart:isolate';

import 'package:blocisolates/events.dart';
import 'package:blocisolates/states.dart';

Future<State> _mapEventToState(Event event) async {
  return switch (event) {
    FibonacciEvent() =>
      FibonacciState(number: event.number, result: _fibonacci(event.number)),
    PrimeEvent() =>
      PrimeState(number: event.number, isPrime: _isPrime(event.number)),
    SlowEvent() =>
      SlowState(number: event.number, result: await _slow(event.number)),
  };
}

_fibonacci(int n) {
  if (n <= 1) return n;
  return _fibonacci(n - 1) + _fibonacci(n - 2);
}

_isPrime(int n) {
  if (n <= 1) return false;
  for (int i = 2; i <= n / 2; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

_slow(int n) {
  return Future.delayed(Duration(seconds: 5), () => n * n);
}

void blocIsolate(SendPort message) {
  final receivePort = ReceivePort();
  message.send(receivePort.sendPort);

  receivePort.listen((event) async {
    if (event is Event) {
      final state = await _mapEventToState(event);
      message.send(state);
    }
  });
}
