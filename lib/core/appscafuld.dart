import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:name_with_numbers/home_page.dart';
import 'package:name_with_numbers/pages/AscendantSignPage/ui/AscendantSignPage.dart';
import 'package:name_with_numbers/pages/CompatibilityPage/CompatibilityPage.dart';
import 'package:name_with_numbers/pages/ZodiacSignPage/ui/zodiacsignpage.dart';
import 'package:name_with_numbers/pages/gematria_page/ui/gematria_page.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showBackButton; // متغير للتحكم في عرض زر الرجوع

  const AppScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.showBackButton = false, // افتراضي لا يظهر زر الرجوع
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // زر الرجوع يظهر هنا بشكل صريح إذا كانت showBackButton = true
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // استخدام Navigator.pushAndRemoveUntil لإزالة جميع الصفحات من المكدس
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage()), // الانتقال إلى الصفحة الرئيسية
                    (Route<dynamic> route) =>
                        false, // إزالة جميع الصفحات من المكدس
                  );
                },
              )
            : null,
        title: Row(
          children: [
            Expanded(
              // استخدام Expanded للسماح للنص بأخذ المساحة المتاحة
              child: Text(
                title,
                style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.w600), // تقليل حجم الخط
                overflow: TextOverflow
                    .ellipsis, // إضافة النقاط الثلاث إذا كان النص أطول من المساحة المتاحة
                softWrap: true, // السماح بتقسيم النص إذا كان طويلًا
                maxLines: 2, // تحديد عدد الأسطر
                textAlign: TextAlign.center, // محاذاة النص في المنتصف
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
        actions: [
          // أيقونة القائمة الجانبية تظهر في الزاوية اليمنى
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer(); // فتح القائمة الجانبية
                },
              );
            },
          ),
        ],
      ),

      endDrawer: _buildDrawer(context), // القائمة الجانبية في الجهة اليمنى
      body: body,
    );
  }

  // بناء القائمة الجانبية (Drawer)
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
            ),
            child: Text(
              'القائمة الرئيسية',
              style: GoogleFonts.cairo(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.calculate, color: Colors.blueGrey[800]),
            title: Text('حساب الجمل', style: GoogleFonts.cairo(fontSize: 18)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GematriaPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.blueGrey[800]),
            title: Text('حساب البرج الطالع',
                style: GoogleFonts.cairo(fontSize: 18)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AscendantSignPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blueGrey[800]),
            title: Text('حساب البرج الفلكي',
                style: GoogleFonts.cairo(fontSize: 18)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ZodiacSignPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.compare, color: Colors.blueGrey[800]),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                '(اسماء)حساب التوافق بين الزوجين',
                style: GoogleFonts.cairo(fontSize: 18),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CompatibilityPage()));
            },
          ),
        ],
      ),
    );
  }
}
