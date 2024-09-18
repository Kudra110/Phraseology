import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:name_with_numbers/core/appscafuld.dart';

class ZodiacSignPage
    extends StatefulWidget {
  @override
  _ZodiacSignPageState createState() =>
      _ZodiacSignPageState();
}

class _ZodiacSignPageState
    extends State<ZodiacSignPage> {
  DateTime?
      _selectedDate;
  String
      _zodiacSign =
      '';
  String?
      _zodiacImage; // Store the path to the zodiac image
  bool
      _showZodiac =
      false;

  void
      _calculateZodiacSign() {
    if (_selectedDate != null) {
      setState(() {
        _zodiacSign = _getZodiacSign(_selectedDate!);
        _zodiacImage = _getZodiacImage(_zodiacSign);
        _showZodiac = true;
      });
    }
  }

  String
      _getZodiacSign(DateTime date) {
    int day = date.day;
    int month = date.month;

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return 'برج الدلو';
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      return 'برج الحوت';
    } else if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return 'برج الحمل';
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return 'برج الثور';
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return 'برج الجوزاء';
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return 'برج السرطان';
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return 'برج الأسد';
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return 'برج العذراء';
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return 'برج الميزان';
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return 'برج العقرب';
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return 'برج القوس';
    } else {
      return 'برج الجدي';
    }
  }

  String?
      _getZodiacImage(String zodiacSign) {
    switch (zodiacSign) {
      case 'برج الدلو':
        return 'assets/images/vecteezy_aquarius-zodiac-sign_10964842.jpg';
      case 'برج الحمل':
        return 'assets/images/vecteezy_aries-zodiac-sign_10966795.jpg';
      case 'برج السرطان':
        return 'assets/images/vecteezy_cancer-zodiac-sign_10964446.jpg';
      case 'برج الجدي':
        return 'assets/images/vecteezy_capricorn-zodiac-sign_10965555.jpg';
      case 'برج الجوزاء':
        return 'assets/images/vecteezy_gemini-zodiac-sign_10966372.jpg';
      case 'برج الأسد':
        return 'assets/images/vecteezy_leo-zodiac-sign_10967022.jpg';
      case 'برج الميزان':
        return 'assets/images/vecteezy_libra-zodiac-sign_10967947.jpg';
      case 'برج الحوت':
        return 'assets/images/vecteezy_pisces-zodiac-sign_10967432.jpg';
      case 'برج القوس':
        return 'assets/images/vecteezy_sagittarius-zodiac-sign_10966361.jpg';
      case 'برج العقرب':
        return 'assets/images/vecteezy_scorpio-zodiac-sign_10967620.jpg';
      case 'برج الثور':
        return 'assets/images/vecteezy_taurus-zodiac-sign_10966533.jpg';
      case 'برج العذراء':
        return 'assets/images/vecteezy_silhouette-of-a-maiden-virgo-zodiac-signs_.jpg';
      default:
        return null;
    }
  }

  void
      _selectDate(BuildContext context) {
    picker.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime(2100, 12, 31),
      onChanged: (date) {
        setState(() {
          _selectedDate = date;
        });
        _calculateZodiacSign();
      },
      onConfirm: (date) {
        setState(() {
          _selectedDate = date;
        });
        _calculateZodiacSign();
      },
      currentTime: DateTime.now(),
      locale: picker.LocaleType.ar,
      theme: picker.DatePickerTheme(
        headerColor: Colors.blueGrey[700],
        backgroundColor: const Color.fromARGB(255, 243, 245, 247),
        itemStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        doneStyle: const TextStyle(color: Color.fromARGB(255, 255, 252, 252), fontSize: 16),
        cancelStyle: const TextStyle(color: Color.fromARGB(255, 255, 254, 254), fontSize: 16),
      ),
    );
  }

  @override
  Widget
      build(BuildContext context) {
    return AppScaffold(
      showBackButton: true,
      title: 'حساب البرج الفلكي',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[600],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _selectDate(context),
                child: Text(
                  'اختر تاريخ الميلاد',
                  style: GoogleFonts.cairo(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              if (_selectedDate != null)
                Text(
                  'التاريخ المختار: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  style: GoogleFonts.cairo(fontSize: 18),
                ),
              const SizedBox(height: 20),
              if (_zodiacImage != null)
                AnimatedOpacity(
                  opacity: _showZodiac ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey, width: 4),
                          borderRadius: const BorderRadius.all(Radius.circular(30)), // Circular border
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30), // Circular image
                          child: Image.asset(
                            _zodiacImage!,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'البرج: $_zodiacSign',
                        style: GoogleFonts.cairo(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
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
}
