import 'package:equatable/equatable.dart';
abstract class GematriaEvent extends Equatable {
  const GematriaEvent();

  @override
  List<Object> get props => [];
}

class CalculateGematria extends GematriaEvent {
  final String name;

  const CalculateGematria(this.name);

  @override
  List<Object> get props => [name];
}