import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:name_with_numbers/core/appscafuld.dart'; // قم بإضافة مسار AppScaffold بشكل صحيح

class ZodiacCompatibilityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'حساب التوافق بين الأبراج',
      showBackButton: true, // تفعيل زر الرجوع في شريط التطبيق
      body: _ZodiacCompatibilityContent(),
    );
  }
}

class _ZodiacCompatibilityContent extends StatefulWidget {
  @override
  __ZodiacCompatibilityContentState createState() =>
      __ZodiacCompatibilityContentState();
}

class __ZodiacCompatibilityContentState
    extends State<_ZodiacCompatibilityContent>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> _zodiacs = [
    {'name': 'الحمل', 'emoji': '♈'},
    {'name': 'الثور', 'emoji': '♉'},
    {'name': 'الجوزاء', 'emoji': '♊'},
    {'name': 'السرطان', 'emoji': '♋'},
    {'name': 'الاسد', 'emoji': '♌'},
    {'name': 'العذراء', 'emoji': '♍'},
    {'name': 'الميزان', 'emoji': '♎'},
    {'name': 'العقرب', 'emoji': '♏'},
    {'name': 'القوس', 'emoji': '♐'},
    {'name': 'الجدي', 'emoji': '♑'},
    {'name': 'الدلو', 'emoji': '♒'},
    {'name': 'الحوت', 'emoji': '♓'},
  ];

  String? _selectedZodiac1;
  String? _selectedZodiac2;
  String _result = "";
  int _finalNumber = 0;
  bool _showResult = false; // للتحكم في إظهار النتيجة مع الأنيميشن

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculateCompatibility() {
    // التحقق من اختيار الأبراج
    if (_selectedZodiac1 == null || _selectedZodiac2 == null) {
      setState(() {
        _result = "يرجى اختيار البرجين لحساب التوافق.";
        _finalNumber = 0;
        _showResult = true; // إظهار النتيجة مع الأنيميشن
      });
      return;
    }

    // حساب قيم الأبراج
    int zodiacValue1 =
        _zodiacs.indexWhere((z) => z['name'] == _selectedZodiac1) + 1;
    int zodiacValue2 =
        _zodiacs.indexWhere((z) => z['name'] == _selectedZodiac2) + 1;

    // جمع البرجين وإسقاط الرقم إذا كان أكبر من 12
    int combinedTotal = zodiacValue1 + zodiacValue2;
    while (combinedTotal > 12) {
      combinedTotal -= 12;
    }

    _finalNumber = combinedTotal;

      // تحديد النتيجة بناءً على الرقم النهائي
    switch (_finalNumber) {
      case 1:
        _result =
            "سعد وهما يصلحان لبعضهم وعلاقتهم ببعضهم قوية.\nنسبة الزواج: % 65.\nبعد الزواج: بداية حياتهم يوجد فيها بعض المتاعب والزعل خاصة أول 5 سنوات.";
        break;
      case 2:
        _result =
            "سعد ويدل على توافق جيد وحصول المال على وجهيهما.\nنسبة الزواج: % 58.\nبعد الزواج: مع الأيام يصبح رحيل وعودة أو طلاق ورجعة.";
        break;
      case 3:
        _result =
            "سعد يدل على المحبة والقبول والألفة مع العائلة.\nنسبة الزواج: % 60.\nبعد الزواج: يخشى من تدخل الأقارب بالعلاقة سلباً.";
        break;
      case 4:
        _result =
            "نحوسات كثيرة بين مد وجزر بين اتفاق وخصام.\nنسبة الزواج: % 50.\nبعد الزواج: العلاقة تصبح أفضل بكثير من قبلها وفيها انسجام.";
        break;
      case 5:
        _result =
            "سعد ويدل على البنون والذرية والأخبار السارة.\nنسبة الزواج: % 68.\nبعد الزواج: ممكن أن يحصل خصام وعداوة بين العائلتين دون الزوجين.";
        break;
      case 6:
        _result =
            "نحس يدل على الهم والغم والمرض والتعب وتعركس الأمور.\nنسبة الزواج: % 45.\nبعد الزواج: تتحسن العلاقة بعد الإنجاب وتقوى الروابط.";
        break;
      case 7:
        _result =
            "سعد جداً ويدل على تيسير الأمور والتوافق الزوجي قبل وبعد الزواج.\nنسبة الزواج: % 75.\nنسبة الزواج: ٪75.\nبعد الزواج: يكثر المال والأرزاق والأولاد والرفاهية.";
        break;
      case 8:
        _result =
            "نحس إمكانية الزواج صعبة ويوجد عثرات كثيرة.\nنسبة الزواج: % 40.\nبعد الزواج: تكون الحياة متعبة ومليئة بالمشاحنات.";
        break;
      case 9:
        _result =
            "نحس فراق وحواجز الارتباط كثيرة كالسفر والرفض.\nنسبة الزواج: % 45 .\nبعد الزواج: حياة غير مستقرة لا يخلو أسبوع من خلاف ومشاجرة.";
        break;
      case 10:
        _result =
            "سعد بين الشريكين ولكن العلاقة مهددة بالفشل بسبب المحيط.\nنسبة الزواج: % 50.\nبعد الزواج: العلاقة تصبح ممتازة وتقوى أكثر من قبل.";
        break;
      case 11:
        _result =
            "سعد وتدل على الارتفاع وعلو الدرجات والمال.\nنسبة الزواج: % 70.\nبعد الزواج: يحصل بعض المتاعب والأمور الصحية والخلافات البسيطة.";
        break;
      case 12:
        _result =
            "نحس شقاء وتعب وهم ورفض من قبل أطراف العائلة.\nنسبة الزواج: % 53.\nبعد الزواج: تصبح أفضل بكثير ويعم الوفاق والخير للجميع.";
        break;
    }

    setState(() {
      _showResult = true; // تفعيل الأنيميشن للنتيجة
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
              _buildZodiacSelectionCard('اختر برج الزوج:', _selectedZodiac1,
                  (newValue) {
                setState(() {
                  _selectedZodiac1 = newValue;
                });
                _animationController.forward(from: 0.0); // بدء الاهتزاز
              }),
              const SizedBox(height: 20),
              _buildZodiacSelectionCard('اختر برج الزوجة:', _selectedZodiac2,
                  (newValue) {
                setState(() {
                  _selectedZodiac2 = newValue;
                });
                _animationController.forward(from: 0.0); // بدء الاهتزاز
              }),
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
                  'احسب التوافق',
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
                        color: Color.fromARGB(255, 163, 1, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),
                    _buildFormattedResultText(_result), // استخدام النص المنسق
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormattedResultText(String result) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.cairo(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color.fromARGB(255, 55, 83, 98)),
        children: _parseResultText(result),
      ),
    );
  }

  List<TextSpan> _parseResultText(String result) {
    List<TextSpan> spans = [];
    final parts = result.split('\n');
    for (String part in parts) {
      spans.add(TextSpan(text: part + '\n'));
    }
    return spans;
  }

  Widget _buildZodiacSelectionCard(
      String label, String? selectedValue, ValueChanged<String?> onChanged) {
    return ShakeTransition(
      animationController: _animationController,
      child: Card(
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
                style: GoogleFonts.cairo(
                    fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => _showZodiacSelectionModal(onChanged),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedValue ?? 'اختر برج',
                        style: GoogleFonts.cairo(fontSize: 18),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showZodiacSelectionModal(ValueChanged<String?> onChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 400,
          child: ListView.builder(
            itemCount: _zodiacs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(_zodiacs[index]['emoji']!,
                    style: TextStyle(fontSize: 24)),
                title: Text(_zodiacs[index]['name']!,
                    style: GoogleFonts.cairo(fontSize: 18)),
                onTap: () {
                  onChanged(_zodiacs[index]['name']);
                  Navigator.pop(context); // إغلاق النافذة المنبثقة
                },
              );
            },
          ),
        );
      },
    );
  }
}

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final AnimationController animationController;

  ShakeTransition({required this.child, required this.animationController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        double offset = 4.0 * (1.0 - animationController.value);
        return Transform.translate(
          offset:
              Offset(offset * (animationController.value % 2 == 0 ? 1 : -1), 0),
          child: child,
        );
      },
      child: child,
    );
  }
}
