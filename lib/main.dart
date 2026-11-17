import 'package:material_ui/material_ui.dart';

import 'calculator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Calculadora',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff176b59)),
      scaffoldBackgroundColor: const Color(0xfff4f3ec),
      fontFamily: 'sans-serif',
    ),
    home: const Calculator(),
  );
}
