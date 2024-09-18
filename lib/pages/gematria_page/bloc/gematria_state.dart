import 'package:equatable/equatable.dart';

abstract class GematriaState extends Equatable {
  const GematriaState();

  @override
  List<Object> get props => [];
}

class GematriaInitial extends GematriaState {}

class GematriaCalculated extends GematriaState {
  final int total;

  const GematriaCalculated(this.total);

  @override
  List<Object> get props => [total];
}
