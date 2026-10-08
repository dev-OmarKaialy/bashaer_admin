/// Emoji offered by the category icon picker. New categories store one glyph
/// (the current contract); `CategoryIcon` draws it monochrome on the badge.
class EmojiCatalog {
  EmojiCatalog._();

  static const List<EmojiGroup> groups = [
    EmojiGroup('vehicles', [
      '🚗',
      '🚙',
      '🚘',
      '🚕',
      '🏎️',
      '🚐',
      '🚚',
      '🚌',
      '🏍️',
      '🛵',
      '🚲',
      '🚜',
    ]),
    EmojiGroup('road', ['🚦', '🚥', '🛑', '⚠️', '🚧', '⛔', '🚸', '🅿️', '🛣️', '🧭', '🗺️', '↩️']),
    EmojiGroup('mechanics', [
      '⚙️',
      '🔧',
      '🔩',
      '🧰',
      '🛞',
      '🛢️',
      '⛽',
      '🔋',
      '🪫',
      '🔌',
      '⚡',
      '💡',
    ]),
    EmojiGroup('safety', [
      '🧯',
      '🚨',
      '🦺',
      '💺',
      '🩹',
      '👮',
      '❄️',
      '🌡️',
      '🌧️',
      '🌫️',
      '🌙',
      '🔦',
    ]),
    EmojiGroup('learning', ['📋', '📝', '📖', '🎓', '🏁', '⏱️', '✅', '❓', '⭐', '🏆', '🎯', '🧠']),
  ];

  /// Font Awesome names already used by seeded categories (legacy rows).
  /// Shown so an edit can keep the current look.
  static const List<String> legacyNames = [
    'snowflake',
    'oil-can',
    'engine',
    'gas-pump',
    'bolt',
    'car-battery',
    'gears',
    'wrench',
    'road',
    'traffic-light',
    'gauge-high',
  ];
}

class EmojiGroup {
  const EmojiGroup(this.key, this.emoji);

  /// Translation key suffix under `categories.iconGroups.*`.
  final String key;
  final List<String> emoji;
}
