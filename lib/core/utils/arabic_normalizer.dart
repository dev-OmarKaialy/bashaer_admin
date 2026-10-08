/// Folds Arabic text for forgiving search: lowercase, no tashkeel or tatweel,
/// and one form for the letters people type interchangeably
/// (أ إ آ ٱ → ا, ى → ي, ة → ه, ؤ → و, ئ → ي). Arabic-Indic digits become
/// Western digits so a phone typed either way matches.
String normalizeForSearch(String input) {
  final buffer = StringBuffer();
  for (final rune in input.toLowerCase().runes) {
    // Tashkeel (U+064B–U+0652), superscript alef (U+0670) and tatweel (U+0640).
    if ((rune >= 0x064B && rune <= 0x0652) || rune == 0x0670 || rune == 0x0640) continue;
    switch (rune) {
      case 0x0623 || 0x0625 || 0x0622 || 0x0671:
        buffer.writeCharCode(0x0627);
      case 0x0649 || 0x0626:
        buffer.writeCharCode(0x064A);
      case 0x0629:
        buffer.writeCharCode(0x0647);
      case 0x0624:
        buffer.writeCharCode(0x0648);
      default:
        if (rune >= 0x0660 && rune <= 0x0669) {
          buffer.writeCharCode(0x30 + rune - 0x0660);
        } else if (rune >= 0x06F0 && rune <= 0x06F9) {
          buffer.writeCharCode(0x30 + rune - 0x06F0);
        } else {
          buffer.writeCharCode(rune);
        }
    }
  }
  return buffer.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
}
