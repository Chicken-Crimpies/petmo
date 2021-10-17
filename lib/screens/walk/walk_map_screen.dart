import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petmo/db/walks_database.dart';
import 'package:petmo/models/walk/active_walk.dart';
import 'package:petmo/models/walk/walk.dart';
import 'package:petmo/screens/pet/pet_screen.dart';

import '../style.dart';

class WalkMapScreen extends StatefulWidget {
  const WalkMapScreen({Key? key}) : super(key: key);

  @override
  _WalkMapScreenState createState() => _WalkMapScreenState();
}

class _WalkMapScreenState extends State<WalkMapScreen> {
  late GoogleMapController mapController;
  late Position position;
  final Set<Marker> _markers = <Marker>{};
  String buttonText = 'Start Walk';
  double distance = 0;
  int duration = 0;
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
    super.initState();
  }

  @override
  void dispose() {
    WalksDatabase.instance.close();
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
    Position res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = res;
    });
    _renderPinsOnMap();
  }

  void _renderPinsOnMap() async {
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'You',
          snippet: 'Yourself',
        )
        // icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/kangaroo_idle.gif'),
        ));

    _markers.add(Marker(
        markerId: MarkerId('other1Pin'),
        position:
            LatLng(position.latitude + 0.002, position.longitude + -0.0034),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Friend',
          snippet: 'Another person',
        )));
  }

  void _updateWalkState() async {
    if (ActiveWalk.isWalkActive()) {
      setState(() {
        distance = Geolocator.distanceBetween(
            ActiveWalk.activeWalk.startPosition.latitude,
            ActiveWalk.activeWalk.startPosition.longitude,
            position.latitude,
            position.longitude);
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
      ActiveWalk.activeWalk.end(position);
    } else {
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
                    ' Meters',
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
  Widget build(BuildContext context) => Scaffold(
        body: Stack(children: [
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
                                borderRadius: BorderRadius.circular(100.0),
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
                .push(MaterialPageRoute(builder: (_) => PetScreen()));
          },
          backgroundColor: PrimaryAccentColor,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
}
