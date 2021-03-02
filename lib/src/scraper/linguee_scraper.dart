import 'package:vokabularium_scraper/src/options/linguee_options.dart';
import 'package:vokabularium_scraper/src/page/linguee_page.dart';
import 'package:vokabularium_scraper/src/parser/linguee_parser.dart';
import 'package:vokabularium_scraper/src/scrap/scrap.dart';
import 'package:vokabularium_scraper/src/parser/parser.dart';
import 'package:vokabularium_scraper/src/scraper/scraper.dart';

class LingueeScraper extends Scraper<LingueePage, LingueeOptions> {
  static const BASE_URL = 'https://www.linguee.de/deutsch-englisch/search';
  static const parser = LingueeParser();

  @override
  String buildURL(LingueeOptions options) {
    return BASE_URL + '?source=${options.source}&query=${options.query}';
  }

  @override
  Parser<LingueePage> getParser() {
    return parser;
  }

  @override
  Future<Scrap<LingueePage>> scrap(LingueeOptions options) async {
    var document = await fetchDocument(options);
    return scrapDocument(document);
  }
}
