abstract class AscendantEvent {}

class CalculateAscendant extends AscendantEvent {
  final String personName;
  final String motherName;

  CalculateAscendant(this.personName, this.motherName);
}