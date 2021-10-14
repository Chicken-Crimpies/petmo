import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petmo/screens/pet/pet_screen.dart';

class WalkMapScreen extends StatefulWidget {
  const WalkMapScreen({Key? key}) : super(key: key);

  @override
  _WalkMapScreenState createState() => _WalkMapScreenState();
}

class _WalkMapScreenState extends State<WalkMapScreen> {
  late GoogleMapController mapController;
  late Position position;
  Set<Marker> _markers = Set<Marker>();

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
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
      ),
      // icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/kangaroo_idle.gif'),
    ));

    _markers.add(Marker(
      markerId: MarkerId('other1Pin'),
      position: LatLng(position.latitude + 0.002, position.longitude + -0.0034),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Friend',
        snippet: 'Another person',
      ),
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16.0,
          ),
          markers: _markers,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PetScreen()));
          },
          backgroundColor: Color(0xff584B53),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
}
