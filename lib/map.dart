
import 'dart:async';
import 'package:custom_marker/marker_icon.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
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
      print(markers);
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

  Future<Set<Marker>> _activateListeners() async {
    _dataStream = _database.child('Teachers').onValue.listen((event) {
      //getmarkers();
      final dynamic teacher = event.snapshot.value;
      setState(() {
        teacher.forEach((k, v){
          print([v['first_name'],v['coordinates']['latitude'],v['coordinates']['longitude']]);
          data.add([v['first_name'],v['last_name'],"assets/gajju.jpg",v['coordinates']['latitude'],v['coordinates']['longitude']]);
        });
      });
  });
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
    print(markers);
    return markers;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF00E1FF),
                  const Color(0xFF00FFEA),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FutureBuilder(
          future: _activateListeners(),
      builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) =>
      snapshot.hasData
          ?
      GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
                initialCameraPosition: _kGoogle,
              mapType: currentMapType,
                myLocationEnabled: true,
                compassEnabled: true,
                markers: snapshot.data,
        ): const Center(
        // render the loading indicator
        child: CircularProgressIndicator(),)
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
        color: Colors.tealAccent,
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFF00E1FF),
                const Color(0xFF00FFEA),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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