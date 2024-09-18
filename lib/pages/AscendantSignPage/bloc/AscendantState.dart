abstract class AscendantState {}

class AscendantInitial extends AscendantState {}

class AscendantCalculated extends AscendantState {
  final int totalNameValue;
  final int totalMotherNameValue;
  final int finalNumber;
  final String ascendantSign;

  AscendantCalculated(this.totalNameValue, this.totalMotherNameValue, this.finalNumber, this.ascendantSign);
}