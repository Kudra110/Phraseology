import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:name_with_numbers/pages/gematria_page/bloc/gematria_bloc.dart';
import 'package:name_with_numbers/pages/gematria_page/bloc/gematria_event.dart';
import 'package:name_with_numbers/pages/gematria_page/bloc/gematria_state.dart';
import 'package:name_with_numbers/core/appscafuld.dart';

class GematriaPage extends StatefulWidget {
  @override
  _GematriaPageState createState() => _GematriaPageState();
}

class _GematriaPageState extends State<GematriaPage> {
  final TextEditingController _controller = TextEditingController();
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackButton: true,
      title: 'حساب الجمل',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
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
                        'أدخل الاسم لحساب الجمل:',
                        style: GoogleFonts.cairo(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'أدخل الاسم هنا',
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[600],
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _showResult = true;
                          });
                          BlocProvider.of<GematriaBloc>(context)
                              .add(CalculateGematria(_controller.text));
                        },
                        child: Text(
                          'احسب',
                          style: GoogleFonts.cairo(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<GematriaBloc, GematriaState>(
                builder: (context, state) {
                  if (state is GematriaCalculated) {
                    return AnimatedOpacity(
                      opacity: _showResult ? 1.0 : 0.0,
                      duration: Duration(seconds: 1),
                      child: _buildResultCard(state.total),
                    );
                  } else {
                    return _buildResultCard(0, empty: true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(int total, {bool empty = false}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      color: Colors.blueGrey[50],
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: empty
            ? Text(
                'أدخل الاسم واضغط على احسب',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: Colors.blueGrey[700],
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )
            : Column(
                children: [
                  Text(
                    'مجموع حساب الجمل هو:',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$total',
                    style: GoogleFonts.robotoMono(
                      fontSize: 36, // تكبير النتيجة لجعلها أكثر بروزًا
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
                ],
              ),
      ),
    );
  }
}
