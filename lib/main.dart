import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_with_numbers/pages/gematria_page/bloc/gematria_bloc.dart';
import 'package:name_with_numbers/home_page.dart';

void
    main() {
  runApp(GematriaApp());
}

class GematriaApp
    extends StatelessWidget {
  @override
  Widget
      build(BuildContext context) {
    return BlocProvider(
      create: (context) => GematriaBloc(), // BlocProvider wrapping the whole app
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'تطبيق حساب الجمل',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: HomePage(), // الصفحة الرئيسية
      ),
    );
  }
}
