import 'package:html/parser.dart' as html_parser;
import 'package:test/test.dart';

import 'package:http/http.dart';
import 'package:vokabularium_scraper/src/parser/linguee_parser.dart';
import 'package:vokabularium_scraper/src/scrap/linguee_scrap.dart';

void main() async {
  var client = Client();
  var response;
  var document;
  var scrap;
  Entry enEntry, deEntry;

  var parser = LingueeParser();

  group('Query: Dart', () {
    setUpAll(() async {
      const url =
          'https://www.linguee.de/deutsch-englisch/search?source=englisch&query=dart';
      response = await client.get(url);

      document = html_parser.parse(response.body);
      scrap = parser.parse(document);

      enEntry =
          scrap.entries.firstWhere((e) => e.source == 'EN', orElse: () => null);
      deEntry =
          scrap.entries.firstWhere((e) => e.source == 'DE', orElse: () => null);
    });

    test('Scrap has exactly 2 entries', () {
      expect(scrap.entries, hasLength(2));
    });

    test('An entry with "DE" source exists', () {
      expect(deEntry, isNotNull);
      // further testing on deEntry is trivial (for this case), it is skipped.
    });

    test('An entry with "EN" source exists', () {
      expect(enEntry, isNotNull);
    });

    test(
        'enEntry.exact.lemmas should contain two lemmas with valid term, pos, translation and examples',
        () {
      var lemmas = enEntry.exact.lemmas;

      expect(lemmas, hasLength(2));

      expect(enEntry.exact.lemmas[0].description.term, 'dart');
      expect(enEntry.exact.lemmas[0].description.pos, 'Substantiv');
      expect(enEntry.exact.lemmas[0].translations.length, 1);
      expect(enEntry.exact.lemmas[0].translations[0].description.pos,
          'Substantiv, maskulin');
      expect(enEntry.exact.lemmas[0].translations[0].description.term, 'Dart');

      expect(enEntry.exact.lemmas[1].description.term, 'dart');
      expect(enEntry.exact.lemmas[1].description.pos, 'Verb');
      expect(enEntry.exact.lemmas[1].translations.length, 1);
      expect(
          enEntry.exact.lemmas[1].translations[0].description.term, 'flitzen');
      expect(enEntry.exact.lemmas[1].translations[0].description.pos, 'Verb');
      expect(enEntry.exact.lemmas[1].translations[0].examples[0].source,
          'The ballboy darted across the court to retrieve the ball.');
      expect(enEntry.exact.lemmas[1].translations[0].examples[0].target,
          'Der Ballboy flitzte über den Tennisplatz, um den Ball zurückzuholen.');
    });

    test('Scrap has 28 examples', () {
      expect(scrap.examples, hasLength(28));

      var testExample = Example(
          'The extension of the DART electrified rail network north and south of Dublin City to the outer suburbs was also assisted as there are more daily passengers on the suburban rail network in Dublin than on the rest of the network combined.',
          'Die Erweiterung des elektrifizierten DART-Schienennetzes nördlich und südlich von Dublin City zu den äußeren Vororten wurde ebenfalls unterstützt, da diese Verbindungen täglich von mehr Fahrgästen genutzt werden als alle Verbindungen des übrigen Bahnnetzes zusammen.');

      expect(scrap.examples, contains(testExample));
    });
  });
}
