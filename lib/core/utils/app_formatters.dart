import 'package:easy_localization/easy_localization.dart';

/// Arabic date and relative-time text with Western digits, matching the
/// students' app (Levantine month names, as in its `AppDateFormatter`).
class AppFormatters {
  AppFormatters._();

  static const _months = [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ];

  static final DateFormat _weekday = DateFormat('EEEE', 'ar');
  static final DateFormat _time = DateFormat('HH:mm');

  /// `15 كانون الثاني 2027`
  static String date(DateTime value) {
    final local = value.toLocal();
    return '${local.day} ${_months[local.month - 1]} ${local.year}';
  }

  /// `الجمعة 15 كانون الثاني 2027`
  static String longDate(DateTime value) => '${_weekday.format(value.toLocal())} ${date(value)}';

  /// `15 كانون الثاني 2027، 14:05`
  static String dateTime(DateTime value) => '${date(value)}، ${_time.format(value.toLocal())}';

  /// Whole calendar days from today to [value] (negative when in the past).
  static int daysFromToday(DateTime value, DateTime now) {
    final a = DateTime(now.year, now.month, now.day);
    final local = value.toLocal();
    final b = DateTime(local.year, local.month, local.day);
    return b.difference(a).inDays;
  }

  /// "منذ 5 دقائق", "منذ ساعتين", "منذ 3 أيام".
  static String ago(DateTime value, DateTime now) {
    final diff = now.difference(value.toLocal());
    if (diff.inMinutes < 1) return 'time.justNow'.tr();
    final String amount;
    if (diff.inHours < 1) {
      amount = plural('time.minutes', diff.inMinutes);
    } else if (diff.inDays < 1) {
      amount = plural('time.hours', diff.inHours);
    } else {
      amount = plural('time.days', diff.inDays);
    }
    return 'time.ago'.tr(namedArgs: {'x': amount});
  }

  /// "ينتهي اليوم", "ينتهي بعد 5 أيام", "انتهى منذ يومين".
  static String untilLabel(DateTime until, DateTime now) {
    final days = daysFromToday(until, now);
    final expired = !until.isAfter(now);
    if (expired) {
      if (days == 0) return 'time.endedToday'.tr();
      return 'time.endedAgo'.tr(namedArgs: {'x': plural('time.days', -days)});
    }
    if (days == 0) return 'time.endsToday'.tr();
    return 'time.endsIn'.tr(namedArgs: {'x': plural('time.days', days)});
  }

  static String days(int count) => plural('time.days', count);

  /// `5` or `5.50`.
  static String price(double value) =>
      value == value.roundToDouble() ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
}
