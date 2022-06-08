class Time {
  static String formatTime(int seconds) {

    int min = seconds ~/ 60;
    int sec = seconds % 60;

    String minutesPadding = min < 10 ? '0' : '';
    String secondsPadding = sec < 10 ? '0' : '';

    return '$minutesPadding$min:$secondsPadding$sec';
  }
}
