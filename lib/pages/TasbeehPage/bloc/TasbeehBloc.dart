import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_with_numbers/pages/TasbeehPage/bloc/TasbeehEvent.dart';
import 'package:name_with_numbers/pages/TasbeehPage/bloc/TasbeehState.dart';

class TasbeehBloc extends Bloc<TasbeehEvent, TasbeehState> {
  TasbeehBloc() : super(TasbeehInitial()) {
    on<CalculateTasbeeh>((event, emit) {
      emit(TasbeehLoading());
      int totalValue;
      // Check if mother's name is provided
      if (event.motherName.isEmpty) {
        // Only use the name if mother's name is not provided
        totalValue = _calculateGematria(event.name);
        List<String> matchedNames = _findMatchingNamesCombination(totalValue);
        emit(TasbeehCalculated(matchedNames, totalValue));
      } else {
        // Use both name and mother's name for calculation
        totalValue = _calculateTotalValue(event.name, event.motherName);
        int remainder = totalValue % 99;
        List<String> matchedNames = _findMatchingNames(remainder);
        emit(TasbeehCalculated(matchedNames, totalValue));
      }
    });
  }

  // Gematria table for letters (Abu Mashar Table)
  final Map<String, int> abuMasharTable = {
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

  // Asma Allah Al-Husna with their corresponding numeric values
  final Map<int, List<String>> asmaAllahAlHusna = {
    66: ['الله', "او", 'الوكيل'],
    298: ['الصبور'],
    299: ['الرحمان'],
    258: ['الرحيم'],
    90: ['الملك'],
    170: ['القدوس'],
    131: ['السلام'],
    145: ['المهيمن'],
    94: ['العزيز'],
    206: ['الجبار'],
    662: ['المتكبر'],
    731: ['الخالق'],
    204: ['البارئ'],
    336: ['المصور'],
    1281: ['الغفار'],
    306: ['القهار'],
    14: ['الوهاب', "او", 'الواجد'],
    308: ['الرزاق'],
    489: ['الفتاح'],
    150: ['العليم'],
    903: ['القابض'],
    72: ['الباسط'],
    1481: ['الخافض'],
    351: ['الرافع'],
    117: ['المعز'],
    770: ['المذل'],
    180: ['السميع'],
    302: ['البصير'],
    68: ['الحكم', "او", 'المحيي'],
    104: ['العدل'],
    129: ['اللطيف'],
    812: ['الخبير'],
    88: ['الحليم'],
    1020: ['العظيم'],
    1286: ['الغفور'],
    526: ['الشكور'],
    110: ['العلي'],
    232: ['الكبير'],
    998: ['الحفيظ'],
    550: ['المقيت'],
    80: ['الحسيب'],
    73: ['الجليل'],
    270: ['الكريم'],
    312: ['الرقيب'],
    55: ['المجيب'],
    137: ['الواسع'],
    78: ['الحكيم'],
    20: ['الودود', "او", 'الهادي'],
    57: ['المجيد'],
    573: ['الباعث'],
    319: ['الشهيد'],
    108: ['الحق'],
    116: ['القوي'],
    500: ['المتين'],
    46: ['الولي'],
    62: ['الحميد', "او", 'الباطن'],
    148: ['المحصي'],
    47: ['المبدئ', "او", 'الوالي'],
    124: ['المعيد'],
    490: ['المميت'],
    18: ['الحي'],
    156: ['القيوم', "او", 'العفو'],
    48: ['الماجد'],
    19: ['الواحد'],
    134: ['الصمد'],
    305: ['القادر'],
    744: ['المقتدر'],
    184: ['المقدم'],
    841: ['المؤخر'],
    37: ['الأول'],
    801: ['الآخر'],
    1106: ['الظاهر'],
    551: ['المتعالي'],
    202: ['البر'],
    409: ['التواب'],
    630: ['المنتقم'],
    287: ['الرؤوف'],
    212: ['مالك الملك'],
    1100: ['ذو الجلال والإكرام', "او", 'المغني'],
    209: ['المقسط'],
    114: ['الجامع'],
    1060: ['الغني'],
    161: ['المانع'],
    1001: ['الضار'],
    201: ['النافع'],
    256: ['النور'],
    86: ['البديع'],
    113: ['الباقي'],
    707: ['الوارث'],
    514: ['الرشيد'],
  };

  // Function to calculate total value by summing the gematria of both the name and mother's name
  int _calculateTotalValue(String name, String motherName) {
    int nameValue = _calculateGematria(name);
    int motherNameValue = _calculateGematria(motherName);
    return nameValue + motherNameValue;
  }

  // Find matching names based on the remainder or exact total value
  List<String> _findMatchingNames(int total) {
    // Check if there's an exact match for the total value in Asma Allah Al-Husna
    if (asmaAllahAlHusna.containsKey(total)) {
      return asmaAllahAlHusna[total]!;
    } else {
      // If no exact match, try to find a combination of names that add up to the total
      return _findMatchingNamesCombination(total);
    }
  }

  // Function to find a combination of names that add up to a certain total
  // Function to find a combination of names that add up to a certain total
// Function to find a combination of names that add up to a certain total using dynamic programming
  List<String> _findMatchingNamesCombination(int total) {
    List<MapEntry<int, List<String>>> entries =
        asmaAllahAlHusna.entries.toList();
    entries.sort((a, b) => a.key.compareTo(
        b.key)); // ترتيب الأسماء حسب القيم العددية من الأصغر إلى الأكبر

    // Dynamic programming array to store the best combination for each total
    List<List<MapEntry<int, List<String>>>> dp =
        List.generate(total + 1, (_) => []);

    // Fill the dp array
    for (int i = 1; i <= total; i++) {
      for (MapEntry<int, List<String>> entry in entries) {
        if (entry.key <= i &&
            (dp[i - entry.key].isNotEmpty || i == entry.key)) {
          List<MapEntry<int, List<String>>> combination = [
            ...dp[i - entry.key],
            entry
          ];
          if (dp[i].isEmpty || combination.length < dp[i].length) {
            dp[i] = combination;
          }
        }
      }
    }

    if (dp[total].isNotEmpty) {
      return dp[total].expand((entry) => entry.value).toList();
    }

    return ['لم يتم العثور على تطابق'];
  }

// Recursive function to find the minimal combination of names
  void _findCombinationRecursive(
    List<MapEntry<int, List<String>>> entries,
    int targetSum,
    int startIndex,
    List<MapEntry<int, List<String>>> currentCombination,
    List<MapEntry<int, List<String>>> bestCombination,
    int maxIterations, // تمرير المتغير الذي يحدد الحد الأقصى للتكرارات
  ) {
    if (maxIterations <= 0) {
      return;
    }

    int currentSum =
        currentCombination.fold(0, (sum, entry) => sum + entry.key);

    if (currentSum == targetSum) {
      // إذا وجدنا مجموعة تحقق المجموع المطلوب، نقارنها بأفضل مجموعة حالية
      if (bestCombination.isEmpty ||
          currentCombination.length < bestCombination.length) {
        bestCombination.clear();
        bestCombination.addAll(currentCombination);
      }
      return;
    }

    if (currentSum > targetSum) {
      return;
    }

    for (int i = startIndex; i < entries.length; i++) {
      if (currentSum + entries[i].key <= targetSum) {
        currentCombination.add(entries[i]);
        _findCombinationRecursive(entries, targetSum, i + 1, currentCombination,
            bestCombination, maxIterations - 1);
        currentCombination.removeLast();
      }
    }
  }

  // Function to calculate gematria value of a name and print the result for debugging
  int _calculateGematria(String name) {
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

  // Function to normalize Arabic letters
  String _normalizeLetters(String input) {
    return input
        .replaceAll('ى', 'أ')
        .replaceAll('ة', 'ت')
        .replaceAll('ؤ', 'و')
        .replaceAll('إ', 'أ')
        .replaceAll('ئ', 'ي')
        .replaceAll('ء', '');
  }
}
