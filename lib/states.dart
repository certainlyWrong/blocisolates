sealed class State {}

final class FibonacciState extends State {
  final int number;
  final int result;
  FibonacciState({required this.number, required this.result});
}

final class PrimeState extends State {
  final int number;
  final bool isPrime;
  PrimeState({required this.number, required this.isPrime});
}

final class SlowState extends State {
  final int number;
  final int result;
  SlowState({required this.number, required this.result});
}
