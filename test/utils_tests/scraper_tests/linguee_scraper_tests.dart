import 'package:test/test.dart';
import 'package:vokabularium_scraper/src/options/linguee_options.dart';
import 'package:vokabularium_scraper/src/scrap/linguee_scrap.dart';
import 'package:vokabularium_scraper/src/scraper/linguee_scraper.dart';

void main(List<String> args) async {
  var scraper = LingueeScraper();

  var options;
  LingueeScrap scrap;

  group('Query: Warm', () {
    setUpAll(() async {
      options = LingueeOptions('Warm');
      scrap = await scraper.scrap(options);
    });
    test('Scrap has 2 entries', () {
      expect(scrap.entries, hasLength(2));
    });
  });
}
