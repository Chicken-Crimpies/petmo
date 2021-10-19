import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:petmo/db/walks_database.dart';
import 'package:petmo/models/user/user_details.dart';
import 'package:petmo/models/walk/active_walk.dart';

const String tableWalks = 'walks';

class WalkFields {
  static final List<String> values = [
    id,
    startPosition,
    endPosition,
    startTime,
    endTime,
    isActive
  ];

  static const String id = '_id';
  static const String startPosition = 'startPosition';
  static const String endPosition = 'endPosition';
  static const String startTime = 'startTime';
  static const String endTime = 'endTime';
  static const String isActive = 'isActive';
}

class Walk {
  final int? id;
  final Position startPosition;
  final Position? endPosition;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isActive;

  const Walk({
    this.id,
    required this.startPosition,
    this.endPosition,
    required this.startTime,
    this.endTime,
    required this.isActive,
  });

  Map<String, dynamic> toMap() => {
        WalkFields.id: id,
        WalkFields.startPosition: jsonEncode(startPosition.toJson()),
        WalkFields.endPosition: endPosition == null
            ? jsonEncode(startPosition.toJson())
            : jsonEncode(endPosition?.toJson()),
        WalkFields.startTime: startTime.toIso8601String(),
        WalkFields.endTime: endTime == null
            ? startTime.toIso8601String()
            : endTime?.toIso8601String(),
        WalkFields.isActive: isActive ? 1 : 0,
      };

  Walk copy({
    int? id,
    Position? startPosition,
    Position? endPosition,
    DateTime? startTime,
    DateTime? endTime,
    bool? isActive,
  }) =>
      Walk(
        id: id ?? this.id,
        startPosition: startPosition ?? this.startPosition,
        endPosition: endPosition ?? this.endPosition,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        isActive: isActive ?? this.isActive,
      );

  static Walk fromMap(Map<String, dynamic> map) => Walk(
        id: map[WalkFields.id] as int?,
        startPosition:
            convertStringToPosition(map[WalkFields.startPosition] as String),
        endPosition:
            convertStringToPosition(map[WalkFields.endPosition] as String),
        startTime: DateTime.parse(map[WalkFields.startTime] as String),
        endTime: DateTime.parse(map[WalkFields.endTime] as String),
        isActive: map[WalkFields.isActive] == 1,
      );

  static Position convertStringToPosition(String position) {
    return Position.fromMap(jsonDecode(position));
  }

  void end(Position position) async {
    ActiveWalk.activeWalk = copy(endTime: DateTime.now(), endPosition: position, isActive: false);
    await WalksDatabase.instance.update(ActiveWalk.activeWalk);
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: UserDetails.email).get().then((value) => value.docs[0].reference.update(UserDetails.toMap()));
  }
}
