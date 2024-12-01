extension DateUtils on DateTime {
  String timeLeft() {
    final now = DateTime.now();
    if (isBefore(now)) {
      return 'Time\'s up';
    }

    final difference = this.difference(now);

    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} left';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} left';
    } else {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} left';
    }
  }

  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }
}
