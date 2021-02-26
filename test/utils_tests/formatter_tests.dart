import 'package:test/test.dart';
import 'package:vokabularium_scraper/src/utils/formatter.dart';

void main(List<String> args) {
  test('Test white spaces normalization', () {
    var s = '\u00A0The quick\u00A0brown fox\tjumps over the\nlazy dog\u00A0';
    var t = ' The quick brown fox jumps over the lazy dog ';
    var r = normalizeWhiteSpaces(s);
    expect(r, t);
  });

  test('Test extra whitespaces removal', () {
    var s = '  The     quick    brown fox    jumps over   the lazy dog      ';
    var t = 'The quick brown fox jumps over the lazy dog';
    var r = removeExtraWhitepsaces(s);
    expect(r, t);
  });

  test('Test text formatting', () {
    var s =
        '\tThe\nquick\n\t\u00A0brown\u00A0 fox    jumps over   the lazy dog     \u00A0\n ';
    var t = 'The quick brown fox jumps over the lazy dog';
    var r = formatText(s);
    expect(r, t);
  });
}
