// tasbeeh_event.dart
import 'package:equatable/equatable.dart';

abstract class TasbeehEvent extends Equatable {
  const TasbeehEvent();

  @override
  List<Object> get props => [];
}

class CalculateTasbeeh extends TasbeehEvent {
  final String name;
final String motherName;
  const CalculateTasbeeh(this.name, this.motherName);

  @override
  List<Object> get props => [name];
}
