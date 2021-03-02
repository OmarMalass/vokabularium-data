import 'package:vokabularium_scraper/src/page/page.dart';
import 'package:vokabularium_scraper/src/scrap/scrap.dart';
import 'package:html/dom.dart';

abstract class Parser<T extends Page> {
  const Parser();

  Scrap<T> parse(Document document);
}
