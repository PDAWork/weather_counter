import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterMin());

  int count = 0;

  void counterIncrement(bool theme) {
    if (count != 10) {
      theme ? count++ : count += 2;
    }

    emit(Count(count));

    if (count >= 10) {
      count = 10;
      emit(CounterMax());
    }
  }

  void counterDecriment(bool theme) {
    if (count != 0) {
      theme ? count-- : count -= 2;
    }

    emit(Count(count));

    if (count <= 0) {
      count = 0;
      emit(CounterMin());
    }
  }
}
