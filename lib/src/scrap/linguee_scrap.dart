import 'package:vokabularium_scraper/src/page/linguee_page.dart';
import 'package:vokabularium_scraper/src/scrap/scrap.dart';

class LingueeScrap extends Scrap<LingueePage> {
  List<Entry> entries;
  List<Example> examples;

  LingueeScrap(this.entries, this.examples);
}

class Entry {
  String source;
  Exact exact;

  Entry(this.source, this.exact);
}

class Exact {
  List<Lemma> lemmas;

  Exact(this.lemmas);
}

class Lemma {
  Description description;
  List<Translation> translations;

  Lemma(this.description, this.translations);
}

class Description {
  String term;
  String pos;

  Description(this.term, this.pos);
}

class Translation {
  Description description;
  List<Example> examples;

  Translation(this.description, this.examples);
}

class Example {
  String source;
  String target;

  Example(this.source, this.target);

  @override
  String toString() {
    return '{source: $source, target: $target}';
  }
}
