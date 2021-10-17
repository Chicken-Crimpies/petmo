import 'package:petmo/models/walk/walk.dart';

class ActiveWalk {
  static late Walk activeWalk;

  static void setActiveWalk(Walk walk) => activeWalk = walk;

  static bool isWalkActive() {
    try {
      return activeWalk.isActive;
    } on Error {
      return false;
    } on Exception {
      return false;
    }
  }
}