import 'package:vibration/vibration.dart';

class Vibrate {
  static final Vibrate _singleton = Vibrate._internal();

  factory Vibrate() {
    return _singleton;
  }

  Vibrate._internal();

  void vibratePhone(int duration) async {
    if (await Vibration.hasVibrator()) {
      if (await Vibration.hasCustomVibrationsSupport()) {
        Vibration.vibrate(duration: duration);
      } else {
        Vibration.vibrate();
        await Future.delayed(Duration(milliseconds: 500));
        Vibration.vibrate();
      }
    }
  }
}
