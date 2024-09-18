import 'package:bloc/bloc.dart';
import 'package:name_with_numbers/pages/gematria_page/bloc/gematria_event.dart';
import 'package:name_with_numbers/pages/gematria_page/bloc/gematria_state.dart';

class GematriaBloc extends Bloc<GematriaEvent, GematriaState> {
  GematriaBloc() : super(GematriaInitial()) {
    on<CalculateGematria>((event, emit) {
      int totalValue = _calculateGematriaAbuMashar(event.name);
      emit(GematriaCalculated(totalValue));
    });
  }

  // جدول حساب الجمل وفق كتاب أبو معشر الفلكي
  Map<String, int> abuMasharTable = {
    'ا':1,'أ': 1, 'ب': 2, 'ج': 3, 'د': 4, 'ه': 5, 'و': 6, 'ز': 7, 'ح': 8, 'ط': 9, 'ي': 10,
    'ك': 20, 'ل': 30, 'م': 40, 'ن': 50, 'س': 60, 'ع': 70, 'ف': 80, 'ص': 90, 'ق': 100,
    'ر': 200, 'ش': 300, 'ت': 400, 'ث': 500, 'خ': 600, 'ذ': 700, 'ض': 800, 'ظ': 900, 'غ': 1000
  };

  int _calculateGematriaAbuMashar(String name) {
    int total = 0;
    String normalizedName = _normalizeLetters(name);
    for (int i = 0; i < normalizedName.length; i++) {
      String letter = normalizedName[i];
      if (abuMasharTable.containsKey(letter)) {
        total += abuMasharTable[letter]!;
      }
    }
    return total;
  }

  String _normalizeLetters(String input) {
    return input
        .replaceAll('ى', 'أ')   // تحويل الألف المقصورة إلى ألف
        .replaceAll('ة', 'ت')   // تحويل التاء المربوطة إلى تاء
        .replaceAll('ؤ', 'و')   // تحويل ؤ إلى و
        .replaceAll('إ', 'أ')   // تحويل إ إلى أ
        .replaceAll('ئ', 'ي')   // تحويل ئ إلى ي
        .replaceAll('ء', '');   // تجاهل الهمزة على السطر
  }
}