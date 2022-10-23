
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:tute_me/cards.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/profile.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
/*
  static final LatLng _kMapCenter =
  LatLng(19, 72);

  static final CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  void _currentLocation() async {

    // Create a map controller
    final GoogleMapController controller = await _controller.future;
    LocationData? currentLocation;
    var location = new Location();
    try {
      // Find and store your location in a variable
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    // Move the map camera to the found location using the controller
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }
*/
  final Completer<GoogleMapController> _controller = Completer();
  var _isSelected = false;
  static const CameraPosition initialPosition = CameraPosition(target: LatLng(45.521563, -122.677433),zoom: 10.0,);

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(45.521563, -122.677433),
          //infoWindow: InfoWindow(title: 'Dr. Gajendra Purohit',),
        onTap: () {
            print("Tapped");
            setState(() {
              if(_isSelected == true){
                _isSelected = false;
              }
              else
                _isSelected = true;
            });
            },
      ),
      Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(18.997962200185533, 72.8379758747611),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text("Map", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: initialPosition,
          mapType: MapType.normal,
          myLocationEnabled: true,
          markers: _createMarker(),
        ),
          _isSelected ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height*0.12,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                child: Row(
                  children: [
                    Image.asset('assets/gajju.jpg'),
                    SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dr. Gajendra Purohit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                          Text("Address:", style: TextStyle(fontWeight: FontWeight.bold,),),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ) : Container(),
      ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlueAccent,
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Home",
                    icon: Icon(Icons.home_outlined),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},//=> Navigator.push(context, MaterialPageRoute(builder: (context) => Map())),
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Locate",
                    icon: Icon(Icons.location_on_rounded,),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyProfile()));
                    },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Account",
                    icon: Icon(Icons.person_outline_rounded,),
                    iconSize: 35,
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}