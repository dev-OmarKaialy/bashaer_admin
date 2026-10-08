/// Date math for license periods. Pure functions, no clock inside: callers pass
/// `now` so the same rules apply in the UI and in use cases.
class LicenseDates {
  LicenseDates._();

  /// Preset periods offered as chips, in months.
  static const presets = [1, 3, 6, 12];

  /// The last moment of [day] in local time (23:59:59). Stored in UTC.
  static DateTime endOfLocalDay(DateTime day) {
    final local = day.toLocal();
    return DateTime(local.year, local.month, local.day, 23, 59, 59);
  }

  /// [months] after [from], clamped to the last day of the target month
  /// (31 Jan + 1 month = 28/29 Feb).
  static DateTime addMonths(DateTime from, int months) {
    final local = from.toLocal();
    final targetMonthIndex = local.month - 1 + months;
    final year = local.year + targetMonthIndex ~/ 12;
    final month = targetMonthIndex % 12 + 1;
    final lastDay = DateTime(year, month + 1, 0).day;
    final day = local.day > lastDay ? lastDay : local.day;
    return DateTime(year, month, day);
  }

  /// Where a preset starts counting: the later of today and the current end
  /// date, so extending an active license never loses days.
  static DateTime presetBase({required DateTime now, DateTime? currentUntil}) {
    final today = DateTime(now.year, now.month, now.day);
    if (currentUntil == null) return today;
    final until = currentUntil.toLocal();
    final untilDay = DateTime(until.year, until.month, until.day);
    return untilDay.isAfter(today) ? untilDay : today;
  }

  /// End of the day [months] after [presetBase].
  static DateTime presetUntil({required DateTime now, DateTime? currentUntil, required int months}) {
    return endOfLocalDay(addMonths(presetBase(now: now, currentUntil: currentUntil), months));
  }
}
