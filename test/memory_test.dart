import 'package:calculadora/memory.dart';
import 'package:flutter_test/flutter_test.dart';

Memory enter(List<String> commands) {
  final memory = Memory();
  for (final command in commands) {
    memory.applyCommand(command);
  }
  return memory;
}

void main() {
  test('evaluates supported operators from left to right', () {
    for (final entry in {
      '+': '10',
      '-': '6',
      'x': '16',
      '/': '4',
      '%': '0',
    }.entries) {
      expect(enter(['8', entry.key, '2', '=']).result, entry.value);
    }
    expect(enter(['2', '+', '3', 'x', '4', '=']).result, '20');
  });
  test('decimal input, duplicate point, clear and delete are safe', () {
    expect(enter(['.', '5', '.', '2']).result, '0.52');
    expect(enter(['1', '2', 'DEL']).result, '1');
    expect(enter(['DEL', 'DEL']).result, '0');
    expect(enter(['9', '+', 'AC', '2', '=']).result, '2');
  });
  test(
    'replaces pending operators and equals without right operand is a no-op',
    () {
      expect(enter(['8', '+', 'x', '2', '=']).result, '16');
      expect(enter(['8', '+', '=']).result, '8');
      expect(enter(['8', '+', '2', '=', '=']).result, '10');
    },
  );
  test('new number after equals starts fresh; operator continues result', () {
    expect(enter(['2', '+', '3', '=', '4']).result, '4');
    expect(enter(['2', '+', '3', '=', 'x', '4', '=']).result, '20');
  });

  test(
    'zero division and modulo recover with digit, clear, delete or sign',
    () {
      for (final operator in ['/', '%']) {
        for (final recovery in ['2', 'AC', 'DEL', '+/-']) {
          final memory = enter(['8', operator, '0', '=']);
          expect(memory.error, 'Não é possível dividir por zero.');
          memory.applyCommand('+');
          memory.applyCommand('=');
          expect(memory.error, isNotNull);
          memory.applyCommand(recovery);
          expect(memory.error, isNull);
        }
      }
    },
  );
  test('signs, negative decimals and deleting the last signed digit', () {
    expect(enter(['2', '+/-', 'x', '3', '=']).result, '-6');
    expect(enter(['2', 'x', '+/-', '3', '=']).result, '-6');
    expect(enter(['+/-', '.', '5', '+', '1', '=']).result, '0.5');
    expect(enter(['2', '+/-', 'DEL']).result, '0');
    expect(enter(['2', '+/-', '+/-']).result, '2');
    expect(enter(['2', '+', '3', '=', '+/-', 'x', '2', '=']).result, '-10');
  });
  test('formats binary decimal artifacts and recurring fractions', () {
    expect(enter(['0', '.', '1', '+', '0', '.', '2', '=']).result, '0.3');
    expect(enter(['1', '/', '3', '=']).result, '0.333333333333');
    expect(enter(['0', '+/-', '+', '0', '=']).result, '0');
    expect(enter(['8', '+/-', '%', '3', '=']).result, '1');
  });
  test(
    'limits input and result magnitude without accepting arbitrary commands',
    () {
      final memory = enter(List.filled(20, '9'));
      expect(memory.result, '999999999999');
      for (final invalid in ['', 'NaN', '1+2', 'abc', 'Infinity', '12', ' ']) {
        memory.applyCommand(invalid);
        expect(memory.result, '999999999999');
      }
      memory.applyCommand('x');
      memory.applyCommand('9');
      memory.applyCommand('=');
      expect(memory.error, 'Resultado fora do limite de 10¹².');
      memory.applyCommand('AC');
      expect(memory.result, '0');
    },
  );
  test(
    'delete after result clears and pending delete edits the right operand',
    () {
      expect(enter(['1', '/', '3', '=', 'DEL']).result, '0');
      expect(enter(['8', '+', 'DEL', '2', '=']).result, '10');
    },
  );
}
