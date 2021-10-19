import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petmo/db/walks_database.dart';
import 'package:petmo/models/user/user_details.dart';
import 'package:petmo/models/walk/active_walk.dart';
import 'package:petmo/models/walk/walk.dart';
import 'package:petmo/screens/pet/home_screen.dart';
import 'package:petmo/screens/play/play_screen.dart';

import '../style.dart';

class WalkMapScreen extends StatefulWidget {
  final bool fromNotification;

  const WalkMapScreen({Key? key, required this.fromNotification})
      : super(key: key);

  @override
  _WalkMapScreenState createState() => _WalkMapScreenState();
}

class _WalkMapScreenState extends State<WalkMapScreen> {
  late GoogleMapController mapController;
  late Position position;
  final Set<Marker> _markers = <Marker>{};
  String buttonText = 'Start Walk';
  int distance = 0;
  int duration = 0;
  Timer? timer;
  bool isLoading = false;
  LinearGradient buttonGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.redAccent,
        Colors.orangeAccent,
      ]);

  @override
  void initState() {
    fetchActiveWalk();
    _getCurrentLocation();
    _setInitialButtonState();
    if (widget.fromNotification && ActiveWalk.isWalkActive()) _handleNotificationPin();
    super.initState();
  }

  @override
  void dispose() {
    WalksDatabase.instance.close();
    timer?.cancel();
    super.dispose();
  }

  Future fetchActiveWalk() async {
    if (await WalksDatabase.instance.doesActiveWalkExist()) {
      ActiveWalk.activeWalk = await WalksDatabase.instance.getActiveWalk();
    }
  }

  Future<Walk> createWalk() async {
    final walk = Walk(
      startPosition: position,
      startTime: DateTime.now(),
      isActive: true,
    );
    return await WalksDatabase.instance.create(walk);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    Position res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = res;
      isLoading = false;
    });
    _renderPinsOnMap();
  }

  void _renderPinsOnMap() async {
    _markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        position: LatLng(position.latitude, position.longitude),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/map_icon_self.jpg'),
        infoWindow: const InfoWindow(
          title: 'You',
          snippet: 'This is your current position',
        )));

    if (widget.fromNotification) {
      _markers.add(Marker(
          markerId: const MarkerId('otherPin'),
          position: LatLng(position.latitude + 0.002,
              position.longitude - 0.0034),
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(devicePixelRatio: 2.5),
              'assets/images/map_icon_other.jpg'),
          infoWindow: const InfoWindow(
            title: 'Friend',
            snippet: 'Another person',
          )));
    }
  }

  void _handleNotificationPin() async {
    final BitmapDescriptor mapIconOther = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/map_icon_other.jpg');
    double latitudeVariation = 0.002;
    double longitudeVariation = -0.0034;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (position.latitude + latitudeVariation > position.latitude) {
        latitudeVariation -= 0.00025;
      }
      if (position.longitude + longitudeVariation < position.longitude) {
        longitudeVariation += 0.00025;
      }

      if (Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              position.latitude + latitudeVariation,
              position.longitude + longitudeVariation) <
          50) {
        setState(() {
          _markers.removeWhere((marker) => marker.markerId.value == 'otherPin');
        });
        timer.cancel();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const PlayScreen()));
      }
      setState(() {
        _markers.removeWhere((marker) => marker.markerId.value == 'otherPin');

        _markers.add(Marker(
            markerId: const MarkerId('otherPin'),
            position: LatLng(position.latitude + latitudeVariation,
                position.longitude + longitudeVariation),
            icon: mapIconOther,
            infoWindow: const InfoWindow(
              title: 'Friend',
              snippet: 'Another person',
            )));
      });
    });
  }

  void _updateWalkState() async {
    if (ActiveWalk.isWalkActive()) {
      setState(() {
        distance = Geolocator.distanceBetween(
                ActiveWalk.activeWalk.startPosition.latitude,
                ActiveWalk.activeWalk.startPosition.longitude,
                position.latitude,
                position.longitude)
            .toInt();
        duration = DateTime.now()
            .difference(ActiveWalk.activeWalk.startTime)
            .inMinutes;
        _showWalkStatDialog(context);
        buttonText = 'Start Walk';
        buttonGradient = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green,
              Colors.lightGreenAccent,
            ]);
      });
      UserDetails.points += distance + duration;
      ActiveWalk.activeWalk.end(position);
    } else {
      if (widget.fromNotification) _handleNotificationPin();
      setState(() {
        buttonText = 'Stop Walk';
        buttonGradient = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.redAccent,
              Colors.orangeAccent,
            ]);
      });
      ActiveWalk.setActiveWalk(await createWalk());
    }
  }

  void _setInitialButtonState() {
    setState(() {
      if (ActiveWalk.isWalkActive()) {
        buttonText = 'Stop Walk';
      } else {
        buttonGradient = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green,
              Colors.lightGreenAccent,
            ]);
      }
    });
  }

  void _showWalkStatDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text('Walk Completed', style: TitleTextStyle),
              content: Text(
                'Duration: ' +
                    duration.toString() +
                    ' Minutes\nDistance: ' +
                    distance.toString() +
                    ' Meters\nPoints Earned: ' +  (distance + duration).toString(),
                style: Body1TextStyle,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close))
              ]));

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [SecondaryAccentColor, LightAccentColor])),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Petmo Map'),
          backgroundColor: PrimaryAccentColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 16.0,
                  ),
                  markers: _markers,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                              onTap: () => {
                                    _updateWalkState(),
                                  },
                              child: Container(
                                  height: 60,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x80000000),
                                          blurRadius: 6.0,
                                          offset: Offset(5.0, 5.0),
                                        )
                                      ],
                                      gradient: buttonGradient),
                                  child: Center(
                                    child: Text(
                                      buttonText,
                                      style: Body2TextStyle,
                                    ),
                                  ))))
                    ])
              ]),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => HomeScreen()));
          },
          backgroundColor: PrimaryAccentColor,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ));
}
