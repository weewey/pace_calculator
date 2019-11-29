class DurationHelpers {
  static String getReadableString(Duration duration) {
    if (duration.inHours > 0) {
      final remainingMinutes = duration.inMinutes % 60;
      final remainingSeconds = (duration.inSeconds -
              (duration.inHours * 60 * 60) -
              (duration.inMinutes * 60)) %
          60;
      return "${duration.inHours}h ${remainingMinutes}m ${remainingSeconds}s";
    } else {
      final remainingSeconds = duration.inSeconds % 60;
      return "${duration.inMinutes}m ${remainingSeconds}s";
    }
  }
}
