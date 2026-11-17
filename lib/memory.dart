/// Sequential arithmetic: operations commit left to right, without precedence.
enum Operation {
  add('+'),
  subtract('-'),
  multiply('x'),
  divide('/'),
  modulo('%');

  const Operation(this.symbol);
  final String symbol;

  double calculate(double left, double right) => switch (this) {
    add => left + right,
    subtract => left - right,
    multiply => left * right,
    divide => left / right,
    modulo => left % right,
  };
}

enum EntryPhase { editing, pending, evaluated, error }

class Memory {
  String _result = '0';
  double _left = 0;
  Operation? _operation;
  EntryPhase _phase = EntryPhase.editing;
  String expression = '';
  String? error;

  String get result => _result;

  void applyCommand(String command) {
    if (command == 'AC') {
      _clear();
      return;
    }
    final operation = Operation.values.where((op) => op.symbol == command);
    if (operation.isNotEmpty) {
      if (_phase != EntryPhase.error) _setOperation(operation.first);
      return;
    }
    switch (command) {
      case '=':
        if (_phase == EntryPhase.editing && _operation != null) _evaluate();
      case 'DEL':
        _delete();
      case '+/-':
        _changeSign();
      default:
        // Public boundary: reject paste, arbitrary text and expression strings.
        if (RegExp(r'^[0-9.]$').hasMatch(command)) _addDigit(command);
    }
  }

  void _clear() {
    _result = '0';
    _left = 0;
    _operation = null;
    _phase = EntryPhase.editing;
    expression = '';
    error = null;
  }

  void _prepareEntry() {
    if (_phase == EntryPhase.error || _phase == EntryPhase.evaluated) _clear();
    if (_phase == EntryPhase.pending) _result = '0';
    _phase = EntryPhase.editing;
  }

  void _addDigit(String digit) {
    _prepareEntry();
    if (digit == '.' && _result.contains('.')) return;
    if (_result.replaceAll(RegExp(r'[-.]'), '').length >= 12) return;
    if (_result == '0' && digit != '.') _result = '';
    if (_result == '-0' && digit != '.') _result = '-';
    _result += digit;
  }

  void _delete() {
    if (_phase == EntryPhase.error || _phase == EntryPhase.evaluated) {
      _clear();
      return;
    }
    _prepareEntry();
    _result = _result.length > 1
        ? _result.substring(0, _result.length - 1)
        : '0';
    if (_result == '-') _result = '0';
  }

  void _changeSign() {
    if (_phase == EntryPhase.error) _clear();
    if (_phase == EntryPhase.pending) _prepareEntry();
    _result = _result.startsWith('-') ? _result.substring(1) : '-$_result';
    if (_phase == EntryPhase.evaluated) expression = '';
  }

  void _setOperation(Operation operation) {
    if (_phase == EntryPhase.editing && _operation != null) _evaluate();
    if (_phase == EntryPhase.error) return;
    _left = double.parse(_result);
    _operation = operation;
    expression = '$_result ${operation.symbol}';
    _phase = EntryPhase.pending;
  }

  void _evaluate() {
    final operation = _operation!;
    final right = double.parse(_result);
    expression = '${_format(_left)} ${operation.symbol} $_result =';
    if (right == 0 &&
        (operation == Operation.divide || operation == Operation.modulo)) {
      _fail('Não é possível dividir por zero.');
      return;
    }
    final value = operation.calculate(_left, right);
    if (!value.isFinite || value.abs() > 1e12) {
      _fail('Resultado fora do limite de 10¹².');
      return;
    }
    _result = _format(value);
    _operation = null;
    _phase = EntryPhase.evaluated;
  }

  void _fail(String message) {
    error = message;
    _operation = null;
    _phase = EntryPhase.error;
  }

  static String _format(double value) {
    if (value == 0) return '0';
    // 12 significant digits hide binary floating-point display artifacts.
    final rounded = double.parse(value.toStringAsPrecision(12));
    final text = rounded.toString();
    return text.endsWith('.0') ? text.substring(0, text.length - 2) : text;
  }
}
