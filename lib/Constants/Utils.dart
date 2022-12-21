import 'package:uuid/uuid.dart';

class Utils {
  static const avatars = [
    "assets/images/deer.png",
    "assets/images/fox.png",
    "assets/images/giraffe.png",
    "assets/images/koala.png",
    "assets/images/shiba-inu.png"
  ];

  static String get uid => Uuid().v1();
}
