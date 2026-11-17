import 'package:calculadora/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> tap(WidgetTester tester, String label) async {
    await tester.ensureVisible(find.byKey(ValueKey('key-$label')));
    await tester.tap(find.byKey(ValueKey('key-$label')));
    await tester.pump();
  }

  testWidgets('touch calculation, error recovery and examples', (tester) async {
    await tester.pumpWidget(const MyApp());
    for (final key in ['8', '/', '0', '=']) {
      await tap(tester, key);
    }
    expect(find.text('Não é possível dividir por zero.'), findsOneWidget);
    await tap(tester, '2');
    expect(find.text('Não é possível dividir por zero.'), findsNothing);
    for (final key in ['+', '3', '=']) {
      await tap(tester, key);
    }
    expect(find.bySemanticsLabel('Resultado: 5'), findsOneWidget);
    await tester.ensureVisible(find.text('0.1 + 0.2'));
    await tester.tap(find.text('0.1 + 0.2'));
    await tester.pump();
    expect(find.bySemanticsLabel('Resultado: 0.3'), findsOneWidget);
  });

  testWidgets('keyboard calculates and supports backspace and escape', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    for (final key in [
      LogicalKeyboardKey.digit8,
      LogicalKeyboardKey.slash,
      LogicalKeyboardKey.digit2,
      LogicalKeyboardKey.enter,
    ]) {
      await tester.sendKeyEvent(key);
    }
    await tester.pump();
    expect(find.bySemanticsLabel('Resultado: 4'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.sendKeyEvent(LogicalKeyboardKey.digit9);
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pump();
    expect(find.bySemanticsLabel('Resultado: 0'), findsOneWidget);
  });

  testWidgets('Enter evaluates while a keypad button has keyboard focus', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    for (final key in [
      LogicalKeyboardKey.digit9,
      LogicalKeyboardKey.slash,
      LogicalKeyboardKey.digit3,
      LogicalKeyboardKey.enter,
    ]) {
      await tester.sendKeyEvent(key);
    }
    await tester.pump();
    expect(find.text('9 / 3 ='), findsOneWidget);
    expect(find.bySemanticsLabel('Resultado: 3'), findsOneWidget);
  });

  for (final size in [
    const Size(320, 568),
    const Size(740, 360),
    const Size(1280, 800),
  ]) {
    testWidgets('fits $size with enlarged text and accessible touch targets', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.8)),
            child: child!,
          ),
          home: const MyApp(),
        ),
      );
      expect(tester.takeException(), isNull);
      final sizeOfKey = tester.getSize(find.byKey(const ValueKey('key-7')));
      expect(sizeOfKey.width, greaterThanOrEqualTo(48));
      expect(sizeOfKey.height, greaterThanOrEqualTo(48));
    });
  }
}
