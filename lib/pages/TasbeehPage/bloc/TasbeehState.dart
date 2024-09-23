// tasbeeh_state.dart
import 'package:equatable/equatable.dart';

abstract class TasbeehState extends Equatable {
  const TasbeehState();

  @override
  List<Object> get props => [];
}

class TasbeehInitial extends TasbeehState {}

class TasbeehLoading extends TasbeehState {

}

class TasbeehCalculated extends TasbeehState {
  final List<String> names;
final int totalValue;
  const TasbeehCalculated(this.names, this.totalValue);

  @override
  List<Object> get props => [names];
}
