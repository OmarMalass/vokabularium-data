import 'dart:html';

import 'package:vokabularium_scraper/src/page/page.dart';
import 'package:vokabularium_scraper/src/scrap/scrap.dart';

abstract class Parser<T extends Page> {
  Scrap<T> parse(Document document);
}
