import 'package:vokabularium_scraper/src/options/options.dart';
import 'package:vokabularium_scraper/src/page/linguee_page.dart';

class LingueeOptions extends Options<LingueePage> {
  String query;
  String source;

  LingueeOptions(this.query, {this.source = 'auto'});
}
