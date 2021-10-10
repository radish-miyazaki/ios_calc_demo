import 'dart:math' as math;
import 'package:intl/intl.dart' as intl;

class Logic {
  final MAX_DIGIT = 9;
  intl.NumberFormat formatter = intl.NumberFormat('#,###.########', 'en_US');

  String _text = "0"; // 押された値の文字
  double _currentValue = 0; // 現在の値
  bool _hasPoint = false; // 小数点かどうかを判断する
  int _numAfterPoint = 0; // 小数点の桁数
  double _memorialValue = 0; // 加算・減算時に保管しておく値
  double _previousValue = 0; // 乗算・割算に保管しておく値
  String _previousOperation = ""; // 加算・減算時に保管しておく演算子
  String _memorialOperation = ""; // 乗算・割算に保管しておく演算子
  double _displayValue = 0; // 表示する値

  get memorialOperation => _memorialOperation;
  get previousOperation => _previousOperation;
  get currentValue => _currentValue;
  get memorialValue => _memorialValue;
  get previousValue => _previousValue;
  get text => _text;

  void input(String text) {
    if (text == ".") {
      _hasPoint = true;
    } else if (text == "C") {
      _clear();
      return;
    } else if (text == "=") {
      if (_previousOperation == 'x' || _previousOperation == '/') {
        double result = _previousOperation == 'x'
            ? _previousValue * _currentValue
            : _previousValue / _currentValue;
        _displayValue =
            _memorialValue + (_memorialOperation == "-" ? -1 : 1) * result;
      } else if (_memorialOperation == "+") {
        _displayValue = _memorialValue + _currentValue;
      } else if (_memorialOperation == "-") {
        _displayValue = _memorialValue - _currentValue;
      }

      _clear();
    } else if (text == "x" || text == "/") {
      if (_previousOperation == "/") {
        _previousValue = _previousValue / _currentValue;
      } else if (_previousOperation == "x") {
        _previousValue = _previousValue * _currentValue;
      } else {
        _previousValue = _currentValue;
      }

      _displayValue = _previousValue;
      _previousOperation = text;
      _currentValue = 0;
    } else if (text == "+" || text == "-") {
      if (_previousOperation == "x" || _previousOperation == "/") {
        _memorialValue = _previousOperation == "x"
            ? _previousValue * _currentValue
            : _previousValue / _currentValue;
        _previousValue = 0;
        _previousOperation = "";
      } else if (_memorialOperation == "+") {
        _memorialValue = _memorialValue + _currentValue;
      } else if (_memorialOperation == "-") {
        _memorialValue = _memorialValue - _currentValue;
      } else {
        _memorialValue = _currentValue;
      }

      _displayValue = _memorialValue;
      _memorialOperation = text;
      _currentValue = 0;
    } else {
      int digit = getDigit(_currentValue);

      if (digit + _numAfterPoint == MAX_DIGIT) {
        //
      } else if (_hasPoint) {
        // 小数の場合の処理
        _numAfterPoint++;
        _currentValue =
            _currentValue + int.parse(text) * math.pow(0.1, _numAfterPoint);
      } else if (_text == '0') {
        _currentValue = double.parse(text);
      } else {
        _currentValue = _currentValue * 10 + double.parse(text);
      }

      _displayValue = _currentValue;
    }

    if (_hasPoint) {
      _text = getDisplayText(_displayValue, numAfterPoint: _numAfterPoint);
    } else {
      _text = getDisplayText(_displayValue);
    }
  }

  void _clear() {
    _currentValue = 0;
    _previousValue = 0;
    _memorialValue = 0;
    _previousOperation = "";
    _memorialOperation = "";
    _text = "0";
  }

  String getDisplayText(double value, {int numAfterPoint = -1}) {
    if (numAfterPoint != -1) {
      int intPart = value.toInt();
      if (numAfterPoint == 0) {
        // 点を打った直後の場合（1.）
        return formatter.format(value) + ".";
      } else if (intPart == value) {
        // 値の整数部分と、すべての値が一致する場合（1.0）
        return formatter.format(intPart) +
            (value - intPart).toStringAsFixed(numAfterPoint).substring(1);
      }
      int digit = getDigit(value);
      int decimalPart = MAX_DIGIT - digit;
      double roundedValue = round(value, decimalPart);
      return formatter.format(roundedValue);
    }
    return formatter.format(value);
  }

  int getDigit(double value) {
    int i = 0;
    for (; 10 <= value; i++) {
      value = value / 10;
    }
    return i + 1;
  }

  double round(double value, int digit) {
    int key = math.pow(10, digit).toInt();
    return (value * key).roundToDouble() / key;
  }
}
