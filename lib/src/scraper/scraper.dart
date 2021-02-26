import 'package:html/dom.dart';

import 'package:vokabularium_scraper/src/page/page.dart';
import 'package:vokabularium_scraper/src/parser/parser.dart';
import 'package:vokabularium_scraper/src/scrap/scrap.dart';

abstract class Scraper<T extends Page> {
  Parser<T> getParser();

  Scrap<T> scrap(Document document) {
    return getParser().parse(document);
  }
}
