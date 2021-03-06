import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:petmo/screens/feed/feed_screen.dart';
import 'package:petmo/screens/play/play_screen_single.dart';
import 'package:petmo/screens/style.dart';
import 'package:petmo/screens/walk/walk_map_screen.dart';

class SpeedDialNavWidget extends StatelessWidget {
  const SpeedDialNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SpeedDial(
        icon: Icons.adjust,
        activeIcon: Icons.close,
        backgroundColor: PrimaryAccentColor,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.white,
        activeForegroundColor: PrimaryAccentColor,
        buttonSize: 56.0,
        visible: true,
        curve: Curves.easeInCubic,
        overlayColor: LightAccentColor,
        overlayOpacity: 0.5,
        elevation: 5.0,
        shape: CircleBorder(),
        direction: SpeedDialDirection.up,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.directions_walk),
              backgroundColor: Colors.white,
              foregroundColor: PrimaryAccentColor,
              label: 'Walk',
              labelBackgroundColor: Colors.white,
              labelStyle: Body1TextStyle,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        const WalkMapScreen(fromNotification: false)));
              }),
          SpeedDialChild(
              child: const Icon(Icons.sports_baseball),
              backgroundColor: Colors.white,
              foregroundColor: PrimaryAccentColor,
              label: 'Play',
              labelBackgroundColor: Colors.white,
              labelStyle: Body1TextStyle,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PlayScreenSingle()));
              }),
          SpeedDialChild(
              child: const Icon(Icons.food_bank_outlined),
              backgroundColor: Colors.white,
              foregroundColor: PrimaryAccentColor,
              label: 'Feed',
              labelBackgroundColor: Colors.white,
              labelStyle: Body1TextStyle,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => FeedScreen()));
              }),
        ],
      );
}
