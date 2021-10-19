import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool renderBackButton = false;

  @override
  void initState() {
    _renderBackButton();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [SecondaryAccentColor, LightAccentColor])),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Petmos Playing'),
            backgroundColor: PrimaryAccentColor,
            centerTitle: true,
            automaticallyImplyLeading: renderBackButton ? true : false,
          ),
          body: Center(
            child: Image.asset('assets/images/kangaroo_play_clear.gif'),
          )));

  void _renderBackButton() {
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        renderBackButton = true;
      });
    });
  }
}
