import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:name_with_numbers/core/appscafuld.dart'; // قم بإضافة مسار AppScaffold بشكل صحيح

class CompatibilityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'حساب التوافق بين الأسماء',
      showBackButton: true, // تفعيل زر الرجوع في شريط التطبيق
      body: _CompatibilityPageContent(),
    );
  }
}

class _CompatibilityPageContent extends StatefulWidget {
  @override
  __CompatibilityPageContentState createState() =>
      __CompatibilityPageContentState();
}

class __CompatibilityPageContentState extends State<_CompatibilityPageContent> {
  final TextEditingController _name1Controller = TextEditingController();
  final TextEditingController _name2Controller = TextEditingController();
  String _result = "";
  int _finalNumber = 0; // متغير لتخزين الرقم النهائي
  bool _showResult = false; // متغير للتحكم في عرض الأنيميشن

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

  String _normalizeLetters(String input) {
    return input
        .replaceAll('ى', 'أ') // تحويل الألف المقصورة إلى ألف
        .replaceAll('ة', 'ت') // تحويل التاء المربوطة إلى تاء
        .replaceAll('ؤ', 'و') // تحويل ؤ إلى و
        .replaceAll('إ', 'أ') // تحويل إ إلى أ
        .replaceAll('ئ', 'ي') // تحويل ئ إلى ي
        .replaceAll('ء', ''); // تجاهل الهمزة على السطر
  }

  int _calculateGematria(String name) {
    int total = 0;
    for (int i = 0; i < name.length; i++) {
      String letter = name[i];
      total += abuMasharTable[letter] ?? 0;
    }
    return total;
  }

  void _calculateCompatibility() {
    if (_name1Controller.text.isEmpty || _name2Controller.text.isEmpty) {
      setState(() {
        _result = "يرجى إدخال أسماء الزوج والزوجة لحساب التوافق.";
        _finalNumber = 0;
        _showResult = true;
      });
      return;
    }

    String name1 = _normalizeLetters(_name1Controller.text);
    String name2 = _normalizeLetters(_name2Controller.text);

    int total1 = _calculateGematria(name1);
    int total2 = _calculateGematria(name2);

    int combinedTotal = total1 + total2 + 7;
    while (combinedTotal > 9) {
      combinedTotal -= 9;
    }

    _finalNumber = combinedTotal;

    switch (combinedTotal) {
      case 1:
        _result =
            "فهو وطئ ولا خير فيه.\nتوافق قليل وقد يكون هنالك مشاكل كبيرة بين الشريكين";
        break;
      case 2:
        _result =
            "فهو طيب.\nهنالك احتمال كبير لتطور العلاقة، وفي هذه العلاقة خير للطرفين";
        break;
      case 3:
        _result =
            "أوله وطئ وأخره رديء ويأتي بعد الضيق الفرج.\nعلاقة صعبة جداً ولكن نهايتها جميلة ورائعة";
        break;
      case 4:
        _result =
            "فيه قوة وتوفيق.\nتوافق قوي ومريح للشريكين، وهنالك توفيق بكل الخطوات التي يتخذانها";
        break;
      case 5:
        _result =
            "فهو بيت الجمع والبنين.\nعلاقة شراكة متينة جداً، فيها الكثير من الحب والرومانسية والأولاد والتماسك";
        break;
      case 6:
        _result =
            "أوله طيب وأخره هم وغم.\nهنالك الكثير من الأفخاخ والعراقيل في هذه العلاقة كما أن فيها الكثير من الكذب والزيف، بدايتها جميلة ولكن ختامها ليس مسكاً";
        break;
      case 7:
        _result =
            "هو بيت الفراش والسعد.\nتوافق الشريكين أكثر من رائع، فيه الراحة والطمأنينة والسعادة وتكوين أسرة متماسكة";
        break;
      case 8:
        _result =
            "فهو بيت اللهو والمتعة.\nعلاقة عابرة ممتعة فيها الكثير من الضحك ولكنها لا تدوم للأبد";
        break;
      case 9:
        _result =
            "فهو بيت الرحيل والنزاع والفرار.\nلا يوجد توافق كبير بين الشريكين، مهما كانت العلاقة جميلة مصيرها الفراق!";
        break;
    }

    setState(() {
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
              _buildInputCard('أدخل اسم الزوج:', _name1Controller),
              const SizedBox(height: 20),
              _buildInputCard('أدخل اسم الزوجة:', _name2Controller),
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
                onPressed: _calculateCompatibility,
                child: Text(
                  'احسب',
                  style: GoogleFonts.cairo(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _showResult ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    Text(
                      _finalNumber != 0 ? 'الرقم النهائي: $_finalNumber' : '',
                      style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 163, 1, 1)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _result,
                      style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 55, 83, 98)),
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
              style: GoogleFonts.cairo(), // إضافة خط Google Fonts هنا
            ),
          ],
        ),
      ),
    );
  }
}
