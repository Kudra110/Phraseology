import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:name_with_numbers/core/appscafuld.dart'; // قم بإضافة مسار AppScaffold بشكل صحيح

class QareenExtractionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'استخراج اسم القرين',
      showBackButton: true,
      body: _QareenExtractionPageContent(),
    );
  }
}

class _QareenExtractionPageContent extends StatefulWidget {
  @override
  __QareenExtractionPageContentState createState() =>
      __QareenExtractionPageContentState();
}

class __QareenExtractionPageContentState
    extends State<_QareenExtractionPageContent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  String _resultUpper = "";
  String _resultLower = "";
  bool _showResult = false;

  // جدول حساب الجُمّل
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
    'غ': 1000,
  };

  // دالة لتطبيع الحروف للتأكد من أن الحروف متوافقة مع الجدول
  String _normalizeLetters(String input) {
    return input
        .replaceAll('ى', 'أ')
        .replaceAll('ة', 'ت')
        .replaceAll('ؤ', 'و')
        .replaceAll('إ', 'أ')
        .replaceAll('ئ', 'ي')
        .replaceAll('ء', '');
  }

  // دالة لتحويل الحروف إلى أرقام باستخدام جدول حساب الجُمّل
  int _calculateGematria(String name) {
    int total = 0;
    for (int i = 0; i < name.length; i++) {
      String letter = name[i];
      total += abuMasharTable[letter] ?? 0;
    }
    return total;
  }

  // دالة استخراج الحرف بناءً على الرقم
  String _getLetterFromNumber(int number) {
    return abuMasharTable.keys.firstWhere(
      (key) => abuMasharTable[key] == number,
      orElse: () => '',
    );
  }

  // دالة لمعالجة الأرقام الكبيرة (أكبر من 1000)
  String _handleThousands(int thousandsDigit) {
    if (thousandsDigit <= 0) return '';
    String result = '';
    if (thousandsDigit >= 1) {
      result += 'غ';
      if (thousandsDigit > 1) {
        String additionalLetter = _getLetterFromNumber(thousandsDigit);
        if (additionalLetter.isNotEmpty) {
          result += additionalLetter;
        }
      }
    }
    return result;
  }

  // دالة استخراج اسم القرين
  void _extractQareenName() {
    if (_nameController.text.isEmpty || _motherNameController.text.isEmpty) {
      setState(() {
        _resultUpper = "يرجى إدخال الاسم واسم الأم.";
        _resultLower = "";
        _showResult = true;
      });
      return;
    }

    String name = _normalizeLetters(_nameController.text);
    String motherName = _normalizeLetters(_motherNameController.text);

    // حساب قيمة الجُمّل للأسماء
    int nameTotal = _calculateGematria(name);
    int motherNameTotal = _calculateGematria(motherName);

    // جمع قيم الأسماء
    int combinedTotal = nameTotal + motherNameTotal;

    // تفكيك الرقم الناتج إلى آحاد، عشرات، مئات، آلاف
    int units = combinedTotal % 10; // 1-9
    int tens = (combinedTotal ~/ 10) % 10 * 10; // 10-90
    int hundreds = (combinedTotal ~/ 100) % 10 * 100; // 100-900
    int thousands = (combinedTotal ~/ 1000); // 1-+

    // استخراج الحروف المقابلة لكل جزء
    String unitsLetter = _getLetterFromNumber(units);
    String tensLetter = _getLetterFromNumber(tens);
    String hundredsLetter = _getLetterFromNumber(hundreds);
    String thousandsLetters = _handleThousands(thousands);

    // جمع الحروف في الترتيب: الآحاد + العشرات + المئات + الآلاف
    String qareenName =
        unitsLetter + tensLetter + hundredsLetter + thousandsLetters;

    // إضافة السر العلوي "اييل"
    String upperQareenName = qareenName + "اييل";

    // إضافة السر السفلي "وطيس"
    String lowerQareenName = qareenName + "طيش";

    setState(() {
      _resultUpper = "اسم القرين العلوي: $upperQareenName";
      _resultLower = "اسم القرين السفلي: $lowerQareenName";
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputCard('أدخل اسمك:', _nameController),
              const SizedBox(height: 20),
              _buildInputCard('أدخل اسم الأم:', _motherNameController),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[600],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _extractQareenName,
                child: Text(
                  'استخرج اسم القرين',
                  style: GoogleFonts.cairo(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              AnimatedOpacity(
                opacity: _showResult ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    Text(
                      _resultUpper,
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 55, 83, 98),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40), // إضافة الفاصل بين الأسماء
                    Text(
                      _resultLower,
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 55, 83, 98),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // بناء بطاقة الإدخال
  Widget _buildInputCard(String label, TextEditingController controller) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              label,
              style:
                  GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'أدخل الاسم هنا',
              ),
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(),
            ),
          ],
        ),
      ),
    );
  }
}
