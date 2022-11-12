
import 'dart:async';
import 'package:custom_marker/marker_icon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
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
  late final Completer<GoogleMapController> _controller = Completer();
  var _searchText;
  var _cardImage;
  dynamic location;
  var _isSelected = false;
  var _cardName;
  var _cardData;
  dynamic data = [];

  final _database = FirebaseDatabase.instance.reference();
  late StreamSubscription _dataStream;

  MapType currentMapType = MapType.normal;
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  void _onMapTypeChanged() {
    setState(() {
      currentMapType = currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  final Set<Marker> markers = Set();

  Set<Marker> getmarkers() {
    print(data);
      for (dynamic items in data) {
        setState(() {
          markers.add(Marker(
            markerId: MarkerId(items[0]),
            position: LatLng(items[3], items[4]),
            infoWindow: InfoWindow(
              onTap: () {
                setState(() {
                  _cardImage = items[2];
                  _cardName = items[0];
                  _cardData = items[1];
                  _isSelected = true;
                });
              },
              title: items[0],
              snippet: items[1],
            ),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              setState(() {
                _cardImage = items[2];
                _cardName = items[0];
                _cardData = items[1];
                _isSelected = true;
              });
            }, //Icon for Marker
          ));
        });
      }
      //print(markers);
      return markers;
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  void mylocationMarker() async{
    dynamic value = await getUserCurrentLocation();
      markers.addLabelMarker(LabelMarker(
        label: "ME",
        markerId: MarkerId("My Location"),
        position: LatLng(value.latitude, value.longitude),
        backgroundColor: Colors.blue,
        visible: true,
      ));
  }

  void _activateListeners() {
    _dataStream = _database.child('Teachers').onValue.listen((event) {
      getmarkers();
      final dynamic teacher = event.snapshot.value;
      setState(() {
        teacher.forEach((k, v){
          print([v['first_name'],v['coordinates']['latitude'],v['coordinates']['longitude']]);
          data.add([v['first_name'],v['last_name'],"assets/gajju.jpg",v['coordinates']['latitude'],v['coordinates']['longitude']]);
        });
      });
  });
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activateListeners();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _dataStream.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    mylocationMarker();
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 80)],
              gradient: LinearGradient(
                colors: [Color(int.parse("0xFF00ACC1")),
                  Color(int.parse("0xFF64FFDA")),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,)
          ),),
        title: Text("Map", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        actions: [
          IconButton(onPressed: _onMapTypeChanged, icon: Icon(Icons.map_rounded,),)
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
            initialCameraPosition: _kGoogle,
          mapType: currentMapType,
            myLocationEnabled: true,
            compassEnabled: true,
            markers: getmarkers(),
        ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                  width: MediaQuery.of(context).size.width*0.8,
                  child: TextField(
                    onTap: () {
                      setState(() {_isSelected = false; });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.search_rounded),
                      hintText: "Search area",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                        print(_searchText);
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        _searchText = value;
                        print(_searchText);
                      });
                    },
                  ),
                ),
              ),
              _isSelected ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.topCenter,
                    //padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height*0.12,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                    child: TextButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.black,
                      ),
                      child: Row(
                        children: [
                          Image.asset(_cardImage),
                          SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_cardName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                                Text(_cardData, style: TextStyle(fontWeight: FontWeight.bold,),),
                              ],
                            ),
                          ),
                          IconButton(onPressed: () {setState(() {_isSelected = false;});}, icon: Icon(Icons.close), iconSize: 20,)
                        ],
                      ),
                    ),
                  ),
                ),
              ) : Container(),
            ],
          ),

      ],
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map_rounded, size: 20),
        onPressed: _onMapTypeChanged,
      ),*/


      bottomNavigationBar: BottomAppBar(


        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 80)],
              gradient: LinearGradient(
                colors: [Color(int.parse("0xFF00ACC1")),
                  Color(int.parse("0xFF64FFDA")),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,)
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