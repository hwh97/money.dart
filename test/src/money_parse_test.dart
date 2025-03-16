/* Copyright (C) S. Brett Sutton - All Rights Reserved
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * Written by Brett Sutton <bsutton@onepub.dev>, Jan 2022
 */

import 'package:money2/money2.dart';
import 'package:test/test.dart';

void main() {
  final usd = Currency.create('USD', 2);
  final euro = Currency.create('EUR', 2,
      symbol: '€',
      groupSeparator: '.',
      decimalSeparator: ',',
      pattern: '0,00 S');
  // final long = Currency.create('LONG', 2);

  // final Money usd10d25 = Money.fromInt(1025, usd);
  // final Money usd10 = Money.fromInt(1000, usd);
  // final Money long1000d90 = Money.fromInt(100090, long);

  group('Money.parse', () {
    test('Default Currency Pattern', () {
      expect(Money.parse(r'$10.25', isoCode: 'USD'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(Money.parse('10.25', isoCode: 'USD', pattern: '#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(Money.parse('USD10.25', isoCode: 'USD', pattern: 'CCC#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(Money.parse(r'$USD10.25', isoCode: 'USD', pattern: 'SCCC#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(Money.parse('1,000.25', isoCode: 'USD', pattern: '#.#'),
          equals(Money.fromInt(100025, isoCode: 'USD')));
    });

    test('Default Currency Pattern with negative number', () {
      expect(Money.parse(r'$-10.25', isoCode: 'USD'),
          equals(Money.fromInt(-1025, isoCode: 'USD')));
      expect(Money.parse('-10.25', isoCode: 'USD', pattern: '#.#'),
          equals(Money.fromInt(-1025, isoCode: 'USD')));
      expect(Money.parse('USD-10.25', isoCode: 'USD', pattern: 'CCC#.#'),
          equals(Money.fromInt(-1025, isoCode: 'USD')));
      expect(Money.parse(r'$USD-10.25', isoCode: 'USD', pattern: 'SCCC#.#'),
          equals(Money.fromInt(-1025, isoCode: 'USD')));
      expect(Money.parse('-1,000.25', isoCode: 'USD', pattern: '#.#'),
          equals(Money.fromInt(-100025, isoCode: 'USD')));
    });

    test('Inverted Decimal Separator with pattern', () {
      expect(Money.parse('10,25', isoCode: 'EUR', pattern: '#.#'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(Money.parse('€10,25', isoCode: 'EUR', pattern: 'S0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(Money.parse('EUR10,25', isoCode: 'EUR', pattern: 'CCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(Money.parse('€EUR10,25', isoCode: 'EUR', pattern: 'SCCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(Money.parse('1.000,25', isoCode: 'EUR', pattern: '#,###.00'),
          equals(Money.fromInt(100025, isoCode: 'EUR')));
      expect(Money.parse('1.000,25', isoCode: 'EUR', pattern: '#,###.00'),
          equals(Money.fromInt(100025, isoCode: 'EUR')));
    });

    test('Inverted Decimal Separator with pattern with negative number', () {
      expect(Money.parse('-10,25', isoCode: 'EUR', pattern: '#.#'),
          equals(Money.fromInt(-1025, isoCode: 'EUR')));
      expect(Money.parse('€-10,25', isoCode: 'EUR', pattern: 'S0.0'),
          equals(Money.fromInt(-1025, isoCode: 'EUR')));
      expect(Money.parse('EUR-10,25', isoCode: 'EUR', pattern: 'CCC0.0'),
          equals(Money.fromInt(-1025, isoCode: 'EUR')));
      expect(Money.parse('€EUR-10,25', isoCode: 'EUR', pattern: 'SCCC0.0'),
          equals(Money.fromInt(-1025, isoCode: 'EUR')));
      expect(Money.parse('-1.000,25', isoCode: 'EUR', pattern: '#,###.00'),
          equals(Money.fromInt(-100025, isoCode: 'EUR')));
      expect(Money.parse('-1.000,25', isoCode: 'EUR', pattern: '#,###.00'),
          equals(Money.fromInt(-100025, isoCode: 'EUR')));
    });

    test(
        'Decode and encode with the same currency should be inverse operations',
        () {
      final currency = Currency.create('MONEY', 0, pattern: '0 CCC');
      const stringValue = '1025 MONEY';
      expect(Money.parseWithCurrency(stringValue, currency).toString(),
          equals(stringValue));

      for (var precision = 1; precision < 5; precision++) {
        final currency = Currency.create('MONEY', precision,
            pattern: '0.${'0' * precision} CCC');
        final stringValue = '1025.${'0' * (precision - 1)}1 MONEY';
        expect(Money.parseWithCurrency(stringValue, currency).toString(),
            equals(stringValue));
      }
    });
  });

  test('Decode and encode with the same currency should be inverse operations',
      () {
    final currency = Currency.create('MONEY', 0, pattern: '0 CCC');
    const stringValue = '1025 MONEY';
    expect(Money.parseWithCurrency(stringValue, currency).toString(),
        equals(stringValue));

    for (var precision = 1; precision < 5; precision++) {
      final currency = Currency.create('MONEY', precision,
          pattern: '0.${'0' * precision} CCC');
      final stringValue = '1025.${'0' * (precision - 1)}1 MONEY';
      expect(Money.parseWithCurrency(stringValue, currency).toString(),
          equals(stringValue));
    }
  });

  group('Currency.parse', () {
    test('Default Currency Pattern', () {
      expect(usd.parse(r'$10.25'), equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(usd.parse('10.25', pattern: '#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(usd.parse('USD10.25', pattern: 'CCC#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(usd.parse(r'$USD10.25', pattern: 'SCCC#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(usd.parse('1,000.25', pattern: '#.#'),
          equals(Money.fromInt(100025, isoCode: 'USD')));
    });

    test('Missing decimals', () {
      expect(euro.parse('€EUR10,2', pattern: 'SCCC0,0'),
          equals(Money.fromInt(1020, isoCode: 'EUR')));
      expect(euro.parse('€EUR10,200', pattern: 'SCCC0,0'),
          equals(Money.fromInt(1020, isoCode: 'EUR')));
    });

    test('White space', () {
      expect(usd.parse(r'$ 10.25', pattern: 'S #.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(usd.parse(r'$USD 10.25', pattern: 'SCCC #.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(usd.parse(r'$ USD 10.25', pattern: 'S CCC #.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
    });

    test('White space with negative number', () {
      expect(usd.parse(r'$ -10.25', pattern: 'S #.#'),
          equals(Money.fromInt(-1025, isoCode: 'USD')));
      expect(usd.parse(r'$USD -10.25', pattern: 'SCCC #.#'),
          equals(Money.fromInt(-1025, isoCode: 'USD')));
      expect(usd.parse(r'$ USD -10.25', pattern: 'S CCC #.#'),
          equals(Money.fromInt(-1025, isoCode: 'USD')));
    });

    test('Inverted Decimal Separator with pattern', () {
      expect(euro.parse('10,25', pattern: '#.#'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(euro.parse('€10,25', pattern: 'S0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(euro.parse('EUR10,25', pattern: 'CCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(euro.parse('€EUR10,25', pattern: 'SCCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(euro.parse('1.000,25', pattern: '#,###.00'),
          equals(Money.fromInt(100025, isoCode: 'EUR')));
      expect(euro.parse('1.000,25', pattern: '#,###.00'),
          equals(Money.fromInt(100025, isoCode: 'EUR')));
    });
  });

  group('Currencies().parse', () {
    Currencies().register(usd);
    Currencies().register(euro);

    test('Default Currency Pattern', () {
      expect(Currencies().parse(r'$USD10.25', pattern: 'SCCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(Currencies().parse('USD10.25', pattern: 'CCC#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(Currencies().parse('USD10.25', pattern: 'CCC#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(Currencies().parse(r'$USD10.25', pattern: 'SCCC#.#'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
      expect(Currencies().parse('USD1,000.25', pattern: 'CCC#.#'),
          equals(Money.fromInt(100025, isoCode: 'USD')));
    });

    test('Inverted Decimal Separator with pattern', () {
      expect(Currencies().parse('EUR10,25', pattern: 'CCC#.#'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(Currencies().parse('€EUR10,25', pattern: 'SCCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(Currencies().parse('EUR10,25', pattern: 'CCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(Currencies().parse('€EUR10,25', pattern: 'SCCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'EUR')));
      expect(Currencies().parse('EUR1.000,25', pattern: 'CCC#,###.00'),
          equals(Money.fromInt(100025, isoCode: 'EUR')));
      expect(Currencies().parse('EUR1.000,25', pattern: 'CCC#,###.00'),
          equals(Money.fromInt(100025, isoCode: 'EUR')));
    });
  });

  group('parse methods', () {
    test('Money', () {
      expect(Money.parse(r'$10.25', isoCode: 'USD'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
    });

    test('Currency', () {
      expect(usd.parse(r'$10.25'), equals(Money.fromInt(1025, isoCode: 'USD')));
    });

    test('Currencies', () {
      expect(Currencies().parse(r'$USD10.25', pattern: 'SCCC0.0'),
          equals(Money.fromInt(1025, isoCode: 'USD')));
    });

    test('example', () {
      final aud = Currency.create('AUD', 2);
      final one = aud.parse(r'$1.12345');
      expect(one.minorUnits.toInt(), equals(112));
      expect(one.format('#'), equals('1'));
      expect(one.format('#.#'), equals('1.1'));
      expect(one.format('#.##'), equals('1.12'));
      expect(one.format('#.000'), equals('1.120'));

      expect(one.format('#.0'), equals('1.1'));
      expect(one.format('#.00'), equals('1.12'));
      expect(one.format('#.000'), equals('1.120'));
    });
  });

  group('MoneyParseException', () {
    test('parse', () {
      expect(() => Money.parse('', isoCode: 'USD'),
          throwsA(isA<MoneyParseException>()));

      expect(() => Money.parse('abcd', isoCode: 'USD'),
          throwsA(isA<MoneyParseException>()));
    });

    test('parseWithCurrency', () {
      final usd = CommonCurrencies().usd;
      expect(() => Money.parseWithCurrency('', usd),
          throwsA(isA<MoneyParseException>()));

      expect(() => Money.parseWithCurrency('abcd', usd),
          throwsA(isA<MoneyParseException>()));
    });
  });

  group('Custom separators', () {
    test('decimal separator as slash', () {
      final euroCurrency = Currency.create('EUR', 2,
          decimalSeparator: '/',
          groupSeparator: ' ',
          symbol: '€',
          pattern: '#,###,###.##S');

      final amount = Money.parseWithCurrency('1 234 567/89€', euroCurrency);
      final formatted = amount.toString();

      expect(formatted, '1 234 567/89€');
    });
  });
}
