import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_with_numbers/pages/AscendantSignPage/bloc/AscendantBloc.dart';
import 'package:name_with_numbers/pages/AscendantSignPage/bloc/AscendantEvent.dart';
import 'package:name_with_numbers/pages/AscendantSignPage/bloc/AscendantState.dart';
import 'package:name_with_numbers/core/appscafuld.dart';

class AscendantSignPage
    extends StatelessWidget {
  @override
  Widget
      build(BuildContext context) {
    return BlocProvider(
      create: (context) => AscendantBloc(),
      child: AppScaffold(
        title: 'حساب البرج الطالع',
        body: _AscendantSignPageContent(),
        showBackButton: true, // إضافة زر الرجوع
      ),
    );
  }
}

class _AscendantSignPageContent
    extends StatelessWidget {
  final TextEditingController
      _nameController =
      TextEditingController();
  final TextEditingController
      _motherNameController =
      TextEditingController();

  @override
  Widget
      build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputCard('أدخل اسم الشخص:', _nameController),
              SizedBox(height: 20),
              _buildInputCard('أدخل اسم الأم:', _motherNameController),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[600],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.read<AscendantBloc>().add(
                        CalculateAscendant(
                          _nameController.text,
                          _motherNameController.text,
                        ),
                      );
                },
                child: Text(
                  'احسب',
                  style: GoogleFonts.cairo(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<AscendantBloc, AscendantState>(
                builder: (context, state) {
                  return TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: state is AscendantCalculated ? 1.0 : 0.0),
                    duration: Duration(milliseconds: 1500),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: state is AscendantCalculated
                        ? _buildResultCard(
                            state.totalNameValue,
                            state.totalMotherNameValue,
                            state.finalNumber,
                            state.ascendantSign,
                            _getAscendantImage(state.ascendantSign),
                          )
                        : SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard(String label,
      TextEditingController controller) {
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
              style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'أدخل الاسم هنا',
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(
      int totalNameValue,
      int totalMotherNameValue,
      int finalNumber,
      String ascendantSign,
      String? ascendantImage) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      color: Colors.blueGrey[50],
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'مجموع اسم الشخص واسم الأم:',
              style: GoogleFonts.cairo(
                fontSize: 18,
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${totalNameValue + totalMotherNameValue}',
              style: GoogleFonts.robotoMono(
                fontSize: 36,
                color: const Color.fromARGB(255, 100, 90, 87),
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'الرقم النهائي: $finalNumber',
              style: GoogleFonts.cairo(fontSize: 18, color: Colors.blueGrey[800], fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (ascendantImage != null)
                  Image.asset(
                    ascendantImage,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 10),
                Text(
                  'البرج الطالع: $ascendantSign',
                  style: GoogleFonts.robotoMono(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String?
      _getAscendantImage(String ascendantSign) {
    switch (ascendantSign) {
      case 'الدلو':
        return 'assets/images/vecteezy_aquarius-zodiac-sign_10964842.jpg';
      case 'الحمل':
        return 'assets/images/vecteezy_aries-zodiac-sign_10966795.jpg';
      case 'السرطان':
        return 'assets/images/vecteezy_cancer-zodiac-sign_10964446.jpg';
      case 'الجدي':
        return 'assets/images/vecteezy_capricorn-zodiac-sign_10965555.jpg';
      case 'الجوزاء':
        return 'assets/images/vecteezy_gemini-zodiac-sign_10966372.jpg';
      case 'الأسد':
        return 'assets/images/vecteezy_leo-zodiac-sign_10967022.jpg';
      case 'الميزان':
        return 'assets/images/vecteezy_libra-zodiac-sign_10967947.jpg';
      case 'الحوت':
        return 'assets/images/vecteezy_pisces-zodiac-sign_10967432.jpg';
      case 'القوس':
        return 'assets/images/vecteezy_sagittarius-zodiac-sign_10966361.jpg';
      case 'العقرب':
        return 'assets/images/vecteezy_scorpio-zodiac-sign_10967620.jpg';
      case 'الثور':
        return 'assets/images/vecteezy_taurus-zodiac-sign_10966533.jpg';
      case 'العذراء':
        return 'assets/images/vecteezy_silhouette-of-a-maiden-virgo-zodiac-signs_.jpg';
      default:
        return null;
    }
  }
}
