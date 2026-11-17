import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'memory.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _memory = Memory();
  static const _rows = [
    ['AC', 'DEL', '%', '/'],
    ['7', '8', '9', 'x'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['+/-', '0', '.', '='],
  ];
  static const _labels = {
    'AC': 'Limpar tudo',
    'DEL': 'Apagar último dígito',
    '%': 'Módulo',
    '/': 'Dividir',
    'x': 'Multiplicar',
    '-': 'Subtrair',
    '+': 'Somar',
    '+/-': 'Trocar sinal',
    '.': 'Separador decimal',
    '=': 'Calcular',
  };
  static const _symbols = {
    'DEL': '⌫',
    '/': '÷',
    'x': '×',
    '-': '−',
    '+/-': '±',
  };

  void _apply(String command) => setState(() => _memory.applyCommand(command));

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final keyboard = HardwareKeyboard.instance;
    if (keyboard.isControlPressed ||
        keyboard.isMetaPressed ||
        keyboard.isAltPressed) {
      return KeyEventResult.ignored;
    }
    final command = switch (event.logicalKey) {
      LogicalKeyboardKey.enter || LogicalKeyboardKey.numpadEnter => '=',
      LogicalKeyboardKey.escape || LogicalKeyboardKey.delete => 'AC',
      LogicalKeyboardKey.backspace => 'DEL',
      LogicalKeyboardKey.f9 => '+/-',
      _ => event.character ?? event.logicalKey.keyLabel,
    };
    final normalized = switch (command) {
      '*' => 'x',
      ',' => '.',
      _ => command,
    };
    if (!_rows.expand((row) => row).contains(normalized)) {
      return KeyEventResult.ignored;
    }
    _apply(normalized);
    return KeyEventResult.handled;
  }

  void _example(List<String> commands) => setState(() {
    _memory.applyCommand('AC');
    for (final command in commands) {
      _memory.applyCommand(command);
    }
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Focus(
      autofocus: true,
      onKeyEvent: _onKey,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            return SingleChildScrollView(
              padding: EdgeInsets.all(wide ? 48 : 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: _intro()),
                            const SizedBox(width: 64),
                            SizedBox(width: 400, child: _panel()),
                          ],
                        )
                      : Column(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: _panel(),
                            ),
                            const SizedBox(height: 24),
                            _intro(),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );

  Widget _intro() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'F L U T T E R  /  LAB 01',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xff176b59),
        ),
      ),
      const SizedBox(height: 16),
      const Text(
        'Conta por conta.',
        style: TextStyle(
          fontSize: 38,
          height: 1.1,
          letterSpacing: -1.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Uma calculadora simples. Espaço para pensar.',
        style: TextStyle(fontSize: 17, color: Color(0xff48534c)),
      ),
      const SizedBox(height: 24),
      const Text(
        'EXPERIMENTE',
        style: TextStyle(
          fontSize: 11,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ActionChip(
            label: const Text('0.1 + 0.2'),
            onPressed: () => _example(['0', '.', '1', '+', '0', '.', '2', '=']),
          ),
          ActionChip(
            label: const Text('8 mod 3'),
            onPressed: () => _example(['8', '%', '3', '=']),
          ),
        ],
      ),
      const SizedBox(height: 20),
      const Text(
        'Da esquerda para a direita.\n% calcula o módulo, não a porcentagem.',
        style: TextStyle(height: 1.6, color: Color(0xff48534c)),
      ),
    ],
  );

  Widget _panel() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xff182b25),
      borderRadius: BorderRadius.circular(28),
      boxShadow: const [
        BoxShadow(
          color: Color(0x22182b25),
          blurRadius: 36,
          offset: Offset(0, 16),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'CALCULADORA',
            style: TextStyle(
              color: Color(0xffc1d5ca),
              letterSpacing: 2,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _memory.expression.isEmpty
                    ? 'Pronto para calcular'
                    : _memory.expression,
                textAlign: TextAlign.end,
                style: const TextStyle(color: Color(0xffc1d5ca), fontSize: 16),
              ),
              const SizedBox(height: 12),
              Semantics(
                label: 'Resultado: ${_memory.result}',
                liveRegion: true,
                child: ExcludeSemantics(
                  child: SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _memory.result,
                        style: const TextStyle(
                          fontSize: 64,
                          height: 1.2,
                          letterSpacing: -2,
                          color: Color(0xfff5f7ed),
                          fontWeight: FontWeight.w300,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_memory.error != null) ...[
                const SizedBox(height: 12),
                Semantics(
                  liveRegion: true,
                  child: Text(
                    _memory.error!,
                    style: const TextStyle(
                      color: Color(0xffffc6b5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Text(
                  'Digite um número ou use AC para recomeçar.',
                  style: TextStyle(color: Color(0xffc1d5ca), fontSize: 13),
                ),
              ],
            ],
          ),
        ),
        for (final row in _rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                for (var index = 0; index < row.length; index++) ...[
                  if (index > 0) const SizedBox(width: 8),
                  Expanded(child: _key(row[index])),
                ],
              ],
            ),
          ),
        const Padding(
          padding: EdgeInsets.only(top: 12, bottom: 4),
          child: Text(
            'Enter = calcular · Esc = limpar · F9 = sinal',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xffc1d5ca), fontSize: 11),
          ),
        ),
      ],
    ),
  );

  Widget _key(String command) {
    final isEqual = command == '=';
    final isNumber = RegExp(r'^[0-9.]$').hasMatch(command);
    return Tooltip(
      message: _labels[command] ?? command,
      child: FilledButton(
        key: ValueKey('key-$command'),
        onPressed: () => _apply(command),
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 64),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isEqual
              ? const Color(0xffd8f788)
              : const Color(0xff2c4037),
          foregroundColor: isEqual
              ? const Color(0xff182b25)
              : isNumber
              ? const Color(0xfff5f7ed)
              : const Color(0xffd8f788),
          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        child: Text(
          _symbols[command] ?? command,
          semanticsLabel: _labels[command] ?? command,
        ),
      ),
    );
  }
}
