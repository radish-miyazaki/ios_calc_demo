import 'package:flutter_test/flutter_test.dart';

void main() {
  int getValue() {
    return 1;
  }

  int? getNullable() {
    return 1;
  }

  int? getNull() {
    return null;
  }

  test('expect', () {
    int i = 1;
    expect(i, 1);
    expect(getValue(), 1);
    expect(getNullable(), 1);
    expect(getNull(), null);

    expect(getValue(), equals(1));

    expect(true, true);
    expect(1.1, 1.1);

    expect(1, 2, skip: true);
  });

  test("数値", () {
    expect(getValue(), equals(1));
    expect(getValue(), isPositive);
    expect(-getValue(), isNegative);
    expect(getValue(), isNonNegative);
    expect(-getValue(), isNonPositive);

    expect(0, isNonPositive);
    expect(0, isNonNegative);

    expect(0, isZero);
    expect(getValue(), isNonZero);

    expect(1.1, equals(1.1));
  });

  test("範囲", () {
    expect(5, greaterThan(4));
    expect(5, greaterThanOrEqualTo(5));

    expect(4, lessThan(5));
    expect(4, lessThanOrEqualTo(4));

    expect(5, inInclusiveRange(4, 5));
    expect(5, inExclusiveRange(4, 6));
    expect(5, inClosedOpenRange(5, 6));
    expect(5.1, inOpenClosedRange(5, 6));

    expect(1, closeTo(2, 1));
    expect(2, closeTo(2, 1));
    expect(3, closeTo(2, 1));
    expect(1 / 3, closeTo(0.3333, 0.0001));
  });

  test('文字列', () {
    String abcd = 'abcd';

    expect(abcd, "abcd");
    expect(abcd, contains("bc"));
    expect(abcd, startsWith("a"));
    expect(abcd, endsWith("d"));

    expect('abcD', equalsIgnoringCase('abcd'));
    expect(' abcd ', equalsIgnoringWhitespace('abcd'));
    expect('abcd', stringContainsInOrder(['a', 'b', 'c', 'd']));
    expect('abcd', stringContainsInOrder(['a', 'c', 'd']));

    expect(abcd, hasLength(4));
    expect(abcd.length, 4);
  });

  test('null', () {
    int? nullableValue = getNullable();
    expect(nullableValue, 1);
    expect(nullableValue, isNotNull);

    int? nullValue = getNull();
    expect(nullValue, null);
    expect(nullValue, isNull);
  });

  test('exception', () {
    Exception ex = Exception();
    expect(ex, isException);

    expect(() => throw Exception(), throwsA(isInstanceOf<Exception>()));
    expect(() => throw "string", throwsA(isInstanceOf<String>()));

    try {
      throw FormatException('Exception test');
      fail('No exception');
    } on FormatException catch (e) {
      // 想定したテスト
      expect(e.message, "Exception test");
    } catch (e) {
      // 想定しないテストなのでテストを失敗させる。
      fail("Difference exception");
    }
  });

  test('List', () {
    List list = [1, 2, 3, 4, 5];
    expect(list, hasLength(5));
    expect(list.length, greaterThan(3));
    expect(list, contains(1));
    expect(list, containsAll([1, 3]));
    expect(list, containsAllInOrder([1, 3, 5]));
    expect(list, orderedEquals([1, 2, 3, 4, 5]));
    expect(list, unorderedEquals([5, 4, 3, 2, 1]));
  });
}
