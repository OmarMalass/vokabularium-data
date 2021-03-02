import 'package:html/dom.dart';

import 'package:vokabularium_scraper/src/page/linguee_page.dart';
import 'package:vokabularium_scraper/src/parser/parser.dart';
import 'package:vokabularium_scraper/src/scrap/linguee_scrap.dart';
import 'package:vokabularium_scraper/src/utils/formatter.dart';

class LingueeParser extends Parser<LingueePage> {
  const LingueeParser();

  @override
  LingueeScrap parse(Document document) {
    var entries = extractEntries(document);
    var examples = extractExamples(document);

    return LingueeScrap(entries, examples);
  }

  List<Entry> extractEntries(Document document) {
    var elements = document
        .querySelectorAll('#dictionary > div.isForeignTerm, div.isMainTerm');
    var entries = elements.map((e) => parseEntry(e)).toList();
    return entries;
  }

  Entry parseEntry(Element element) {
    var source = element.attributes['data-source-lang'];
    var exact = extractExact(element);
    return Entry(source, exact);
  }

  Exact extractExact(Element parent) {
    var element = parent.querySelector('div.exact');
    var lemmas = extractLemmas(element);
    return Exact(lemmas);
  }

  List<Lemma> extractLemmas(Element parent) {
    var elements = parent.querySelectorAll('div.lemma');
    return elements.map((e) => parseLemma(e)).toList();
  }

  Lemma parseLemma(Element element) {
    var description = extractLemmaDescription(element);
    var translations = extractLemmaTranslations(element);
    return Lemma(description, translations);
  }

  Description extractLemmaDescription(Element parent) {
    var element = parent.querySelector('h2.line.lemma_desc');
    var term = extractLemmaTerm(element);
    var pos = extractLemmaPOS(element);
    return Description(term, pos);
  }

  String extractLemmaTerm(Element parent) {
    var element = parent.querySelector('span.tag_lemma > a.dictLink');
    return element.text;
  }

  String extractLemmaPOS(Element parent) {
    var element = parent.querySelector('span.tag_lemma > span.tag_wordtype');
    return element.text;
  }

  List<Translation> extractLemmaTranslations(Element parent) {
    var elements = parent.querySelectorAll(
        'div.lemma_content > div.meaninggroup  > div.translation_lines > div.translation');
    return elements.map((e) => parseTranlation(e)).toList();
  }

  Translation parseTranlation(Element element) {
    var description = extractTranslationDescription(element);
    var examples = extractTranslationExamples(element);

    return Translation(description, examples);
  }

  Description extractTranslationDescription(Element parent) {
    var element = parent.querySelector('h3.translation_desc > span.tag_trans');

    var term = extractTranslationMeaning(element);
    var pos = extractTranslationPOS(element);
    return Description(term, pos);
  }

  String extractTranslationMeaning(Element parent) {
    var element = parent.querySelector('a.dictLink');

    element.querySelector('span.placeholder')?.remove();

    return formatText(element.text);
  }

  String extractTranslationPOS(Element parent) {
    var element = parent.querySelector('span.tag_type');

    var posText = element?.attributes['title'] ?? '';

    return formatText(posText);
  }

  List<Example> extractTranslationExamples(Element parent) {
    var elements = parent.querySelectorAll('div.example_lines > div.example');
    return elements.map((e) => parseTranslationExample(e)).toList();
  }

  Example parseTranslationExample(Element parent) {
    var source = parent.querySelector('span.tag_e > span.tag_s').text;
    var target = parent.querySelector('span.tag_e > span.tag_t').text;

    return Example(source, target);
  }

  List<Example> extractExamples(Document document) {
    var elements = document
        .querySelector(
            'div#result_container table.result_table > tbody.examples')
        .querySelectorAll('tr');
    return elements.map((e) => parseExample(e)).toList();
  }

  Example parseExample(Element parent) {
    var elements = parent.querySelectorAll('td.sentence');
    var sentences = elements.map((e) => parseSentence(e)).toList();
    return Example(sentences[0], sentences[1]);
  }

  String parseSentence(Element element) {
    element
        .querySelectorAll('span[class^=placeholder]')
        .forEach((e) => e.remove());

    element
        .querySelectorAll('div[class^=source_url]')
        .forEach((e) => e.remove());

    return formatText(element.text);
  }
}
