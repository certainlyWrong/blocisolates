sealed class Event {
  String get name;
}

final class FibonacciEvent extends Event {
  final int number;
  FibonacciEvent(this.number);

  @override
  String get name => 'FibonacciEvent';
}

final class PrimeEvent extends Event {
  final int number;
  PrimeEvent(this.number);

  @override
  String get name => 'PrimeEvent';
}

final class SlowEvent extends Event {
  final int number;
  SlowEvent(this.number);

  @override
  String get name => 'SlowEvent';
}
