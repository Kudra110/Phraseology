import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:name_with_numbers/pages/AscendantSignPage/ui/AscendantSignPage.dart';
import 'package:name_with_numbers/core/appscafuld.dart';
import 'package:name_with_numbers/pages/ZodiacSignPage/ui/zodiacsignpage.dart';
import 'package:name_with_numbers/pages/gematria_page/ui/gematria_page.dart';

class HomePage
    extends StatelessWidget {
  @override
  Widget
      build(BuildContext context) {
    return AppScaffold(
      title: 'الصفحة الرئيسية',
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCard(context, 'حساب الجمل', Icons.calculate, GematriaPage()),
                SizedBox(height: 20),
                _buildCard(context, 'حساب البرج الطالع', Icons.self_improvement_rounded, AscendantSignPage()),
                SizedBox(height: 20),
                _buildCard(context, 'حساب البرج الفلكي', Icons.date_range, ZodiacSignPage()), // كارد جديد للبرج بالتاريخ الميلادي
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context,
      String title,
      IconData icon,
      Widget page) {
    return SizedBox(
      width: double.infinity, // جعل البطاقات تأخذ عرض الشاشة بالكامل
      height: 150, // ضبط ارتفاع ثابت لكل بطاقة
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        color: Colors.grey[100],
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: Colors.blueGrey[800]),
                SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
