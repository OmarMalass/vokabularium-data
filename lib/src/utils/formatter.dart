RegExp whiteSpacesPattern = RegExp(r'\s');

String normalizeWhiteSpaces(String s) {
  return s.replaceAll(whiteSpacesPattern, ' ');
}

RegExp extraSpacesPattern = RegExp(r'\s+');
RegExp startTrailingSpaces = RegExp(r'(^\s)|(\s$)');

String removeExtraWhitepsaces(String s) {
  return s
      .replaceAll(extraSpacesPattern, ' ')
      .replaceAll(startTrailingSpaces, '');
}

String formatText(String s, {bool extraWS = true, bool normWS = true}) {
  var formatted = s;
  if (extraWS) formatted = normalizeWhiteSpaces(formatted);
  if (normWS) formatted = removeExtraWhitepsaces(formatted);
  return formatted;
}
