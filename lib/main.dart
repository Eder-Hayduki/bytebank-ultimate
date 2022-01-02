import 'package:bytebank_ultimate/palette.dart';
import 'package:bytebank_ultimate/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const ByteBankApp());
  print(Uuid().v4());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Palette.darkGreen,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green[700],
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.darkGreen)
            .copyWith(secondary: Colors.green[700]),
      ),
      home: Dashboard(),
    );
  }
}
