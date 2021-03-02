import 'package:html/dom.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:vokabularium_scraper/src/options/options.dart';

import 'package:vokabularium_scraper/src/page/page.dart';
import 'package:vokabularium_scraper/src/parser/parser.dart';
import 'package:vokabularium_scraper/src/scrap/scrap.dart';

abstract class Scraper<T extends Page, O extends Options<T>> {
  static var client = Client();

  String buildURL(O options);

  Future<Scrap<T>> scrap(O options);

  Parser<T> getParser();

  Future<Document> fetchDocument(O options) => fetch(buildURL(options));

  Future<Document> fetch(String url) async {
    var response = await client.get(url);
    return html_parser.parse(response.body);
  }

  Scrap<T> scrapDocument(Document document) => getParser().parse(document);
}
