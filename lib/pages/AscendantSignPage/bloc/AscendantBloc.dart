import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_with_numbers/pages/AscendantSignPage/bloc/AscendantEvent.dart';
import 'package:name_with_numbers/pages/AscendantSignPage/bloc/AscendantState.dart';

class AscendantBloc extends Bloc<
    AscendantEvent,
    AscendantState> {
  AscendantBloc()
      : super(AscendantInitial()) {
    on<CalculateAscendant>((event, emit) {
      // إجراء الحسابات
      final totalNameValue = _calculateNameValue(event.personName);
      final totalMotherNameValue = _calculateNameValue(event.motherName);
      final sum = totalNameValue + totalMotherNameValue;
      int finalNumber = sum;

      // طرح 12 بشكل متكرر حتى يكون الرقم أصغر أو يساوي 12
      while (finalNumber > 12) {
        finalNumber -= 12;
      }

      // خريطة الأبراج بناءً على الرقم النهائي
      final ascendantSigns = {
        1: 'الحمل',
        2: 'الثور',
        3: 'الجوزاء',
        4: 'السرطان',
        5: 'الأسد',
        6: 'العذراء',
        7: 'الميزان',
        8: 'العقرب',
        9: 'القوس',
        10: 'الجدي',
        11: 'الدلو',
        12: 'الحوت',
      };

      final ascendantSign = ascendantSigns[finalNumber] ?? 'غير معروف';

      // إصدار الحالة الجديدة مع النتائج
      emit(AscendantCalculated(totalNameValue, totalMotherNameValue, finalNumber, ascendantSign));
    });
  }

  // دالة لحساب القيمة الرقمية للاسم
  int _calculateNameValue(String name) {
    Map<String, int> gematriaTable = {
      'ا': 1,
      'أ': 1,
      'ب': 2,
      'ج': 3,
      'د': 4,
      'ه': 5,
      'و': 6,
      'ز': 7,
      'ح': 8,
      'ط': 9,
      'ي': 10,
      'ك': 20,
      'ل': 30,
      'م': 40,
      'ن': 50,
      'س': 60,
      'ع': 70,
      'ف': 80,
      'ص': 90,
      'ق': 100,
      'ر': 200,
      'ش': 300,
      'ت': 400,
      'ث': 500,
      'خ': 600,
      'ذ': 700,
      'ض': 800,
      'ظ': 900,
      'غ': 1000
    };

    String normalized = _normalizeLetters(name);
    int total = 0;
    for (int i = 0; i < normalized.length; i++) {
      String letter = normalized[i];
      if (gematriaTable.containsKey(letter)) {
        total += gematriaTable[letter]!;
      }
    }
    return total;
  }

  // دالة لتطبيع الأحرف قبل الحساب
  String
      _normalizeLetters(String input) {
    return input
        .replaceAll('ى', 'أ') // تحويل الألف المقصورة إلى ألف
        .replaceAll('ة', 'ت') // تحويل التاء المربوطة إلى تاء
        .replaceAll('ؤ', 'و') // تحويل ؤ إلى و
        .replaceAll('إ', 'أ') // تحويل إ إلى أ
        .replaceAll('ئ', 'ي') // تحويل ئ إلى ي
        .replaceAll('ء', ''); // تجاهل الهمزة على السطر
  }
}
