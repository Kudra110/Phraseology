// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_with_numbers/core/appscafuld.dart';
import 'package:name_with_numbers/pages/TasbeehPage/bloc/TasbeehBloc.dart';
import 'package:name_with_numbers/pages/TasbeehPage/bloc/TasbeehEvent.dart';
import 'package:name_with_numbers/pages/TasbeehPage/bloc/TasbeehState.dart';

class TasbeehPage extends StatefulWidget {
  const TasbeehPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TasbeehPageState createState() => _TasbeehPageState();
}

class _TasbeehPageState extends State<TasbeehPage> {
  // Text controllers for name and mother's name
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackButton: true,
      title: 'حساب التسبيح',
      body: SingleChildScrollView(
        child: Center(
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
                          'أدخل الاسم واسم الأم لحساب التسبيح:',
                          style: GoogleFonts.cairo(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'أدخل الاسم هنا',
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _motherNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'أدخل اسم الأم هنا',
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[600],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {});
                            // Trigger the event with name only if mother's name is empty
                            BlocProvider.of<TasbeehBloc>(context).add(
                              CalculateTasbeeh(
                                _nameController.text,
                                _motherNameController.text.isEmpty
                                    ? '' // If mother's name is empty, send an empty string
                                    : _motherNameController.text,
                              ),
                            );
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
                const SizedBox(height: 20),
                BlocBuilder<TasbeehBloc, TasbeehState>(
                  builder: (context, state) {
                    if (state is TasbeehLoading) {
                      return const CircularProgressIndicator(); // Optional loading spinner
                    } else if (state is TasbeehCalculated) {
                      return _buildResultCard(state.names, state.totalValue);
                    } else {
                      return _buildResultCard([], 0, empty: true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to build the result card with names
  Widget _buildResultCard(List<String> names, int total, {bool empty = false}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      color: Colors.blueGrey[50],
      child: Container(
        padding: const EdgeInsets.all(20),
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
                    ' : تسبيحك هو',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...names.map((name) => Text(
                        name,
                        style: GoogleFonts.robotoMono(
                          fontSize: 20,
                          color: name == "او"
                              ? Colors.green
                              : Colors.blueGrey[800],
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'مرات التسبيح: $total',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 17, 12, 129),
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
