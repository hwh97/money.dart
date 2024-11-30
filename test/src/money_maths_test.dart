import 'package:money2/money2.dart';
import 'package:test/test.dart';

void main() {
  group('percentage', () {
    test('create', () {
      expect(Percentage(20, decimalDigits: 0).toString(), equals('20%'));
      expect(Percentage(205, decimalDigits: 1).toString(), equals('20.5%'));

      expect(Percentage.tryParse('20', decimalDigits: 0).toString(),
          equals('20%'));
      expect(Percentage.tryParse('20.5', decimalDigits: 1).toString(),
          equals('20.5%'));

      expect(Percentage.tryParse('20'),
          equals(Percentage.fromInt(20, decimalDigits: 0)));
      expect(Percentage.tryParse('20.5'),
          equals(Percentage.fromInt(205, decimalDigits: 1)));
      expect(Percentage.tryParse('20.5').toString(), equals('20.50%'));
      expect(Percentage.tryParse('10', decimalDigits: 0),
          equals(Percentage.fromInt(10, decimalDigits: 0)));
      expect(
          Percentage.fromInt(10, decimalDigits: 0).toString(), equals('10%'));
      expect(Percentage.fromInt(10).toString(), equals('0.10%'));
    });
    test('percentageOf', () {
      final onehundred =
          Money.fromInt(100000, isoCode: 'AUD', decimalDigits: 3);
      final ten = Money.fromInt(1000, isoCode: 'AUD', decimalDigits: 2);

      var percentage = ten.percentageOf(onehundred);
      expect(percentage, equals(Percentage.fromInt(10, decimalDigits: 0)));
      expect(percentage.scale, equals(onehundred.decimalDigits));

      final three = Money.fromInt(3, isoCode: 'AUD', decimalDigits: 0);

      percentage = three.percentageOf(onehundred);
      expect(percentage, equals(Percentage.fromInt(3, decimalDigits: 0)));
      expect(percentage.scale, equals(onehundred.decimalDigits));

      percentage = onehundred.percentageOf(onehundred);
      expect(percentage, equals(Percentage.fromInt(100, decimalDigits: 0)));
      expect(percentage.scale, equals(onehundred.decimalDigits));
    });

    test('multipliedBy', () {
      final onehundred =
          Money.fromInt(100000, isoCode: 'AUD', decimalDigits: 3);

      final ten = Money.fromInt(10000, isoCode: 'AUD', decimalDigits: 3);
      final tenPercent = Percentage.tryParse('10');
      expect(onehundred.multipliedByPercentage(tenPercent), equals(ten));

      final threePercent = Percentage.tryParse('3');
      final three = Money.fromInt(3000, isoCode: 'AUD', decimalDigits: 3);
      expect(onehundred.multipliedByPercentage(threePercent), equals(three));
    });
  });

  test('division', () {
    final amount = Money.parse('314.00', isoCode: 'AUD');

    final result = amount.divideByFixed(Fixed.one);

    expect(result.amount, equals(Fixed.fromInt(314, scale: 0)));
    expect(result.decimalDigits, equals(2));
  });
}
