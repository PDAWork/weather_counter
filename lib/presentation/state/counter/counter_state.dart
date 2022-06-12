part of 'counter_cubit.dart';

abstract class CounterState extends Equatable {
  const CounterState();
  @override
  List<Object> get props => [];
}

class Count extends CounterState {
  final int count;

  const Count(this.count);

  @override
  List<Object> get props => [count];
}

class CounterMax extends CounterState {}

class CounterMin extends CounterState {}
