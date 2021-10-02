import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:petmo/screens/style.dart';

class SpeedDialNavWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SpeedDial(
        icon: Icons.adjust,
        //icon on Floating action button
        activeIcon: Icons.close,
        //icon when menu is expanded on button
        backgroundColor: SecondaryAccentColor,
        //background color of button
        foregroundColor: Colors.white,
        //font color, icon color in button
        activeBackgroundColor: TertiaryAccentColor,
        //background color when menu is expanded
        activeForegroundColor: Colors.white,
        buttonSize: 64.0,
        //button size
        visible: true,
        closeManually: false,
        curve: Curves.easeInCubic,
        overlayColor: LightAccentColor,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        // action when menu opens
        onClose: () => print('DIAL CLOSED'),
        //action when menu closes
        elevation: 8.0,
        //shadow elevation of button
        shape: CircleBorder(),
        //shape of button
        children: [
          SpeedDialChild(
            //speed dial child
            child: const Icon(Icons.directions_walk),
            backgroundColor: SecondaryAccentColor,
            foregroundColor: Colors.white,
            label: 'Walk',
            labelBackgroundColor: LightAccentColor,
            labelStyle: Body1TextStyle,
            onTap: () => print('FIRST CHILD'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.local_play),
            backgroundColor: SecondaryAccentColor,
            foregroundColor: Colors.white,
            label: 'Play',
            labelBackgroundColor: LightAccentColor,
            labelStyle: Body1TextStyle,
            onTap: () => print('SECOND CHILD'),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.fastfood),
            backgroundColor: SecondaryAccentColor,
            foregroundColor: Colors.white,
            label: 'Feed',
            labelBackgroundColor: LightAccentColor,
            labelStyle: Body1TextStyle,
            onTap: () => print('THIRD CHILD'),
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),
        ],
      );
}
