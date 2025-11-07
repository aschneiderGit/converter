import 'package:test/test.dart';

void expectSameDate(DateTime actual, DateTime expected) {
  expect(actual.year, equals(expected.year));
  expect(actual.month, equals(expected.month));
  expect(actual.day, equals(expected.day));
  expect(actual.hour, equals(expected.hour));
}
