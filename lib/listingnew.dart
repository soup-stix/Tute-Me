
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/profile.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'models.dart';

class Item{
  Item(this.title);
  String title;
  bool selected = false;
}

var techstackjson = [
  {
    'name': 'class 1'
  },
  {
    'name': 'class 2'
  },
  {
    'name': 'class 3'
  },
  {
    'name': 'class 4'
  },
  {
    'name': 'class 5'
  },
  {
    'name': 'class 6'
  },
  {
    'name': 'class 7'
  },
  {
    'name': 'class 8'
  },
  {
    'name': 'class 9'
  },
  {
    'name': 'class 10'
  },
  {
    'name': 'class 11'
  },
  {
    'name': 'class 12'
  },
];




class Listing extends StatefulWidget {


  const Listing({Key? key}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}


class _ListingState extends State<Listing> {
  var indexs = [];
  int? selectedIndex;
  bool _loadingWidget = false;
  dynamic _latitude;
  dynamic _longitude;
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  var futures;

  bool isSelected(index, List indexs) {
    if (indexs.contains(index)) {
      return true;
    }
    return false;
  }
  Future<List<TechStacks>> getTeckstack() async {
    // Future.delayed(const Duration(milliseconds: 1500), () {
    //   // deleayed code here

    // });
    List<TechStacks> techStacks =
    techstackjson.map((e) => TechStacks.fromJson(e)).toList();

    return techStacks;
  }


  @override
  void initState() {
    super.initState();
    futures = getTeckstack();
    _nameController.addListener(_printLatestValue);
    _addressController.addListener(_printLatestValue);
    _phoneController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Address field: ${_addressController.text}');
    print('Name field: ${_nameController.text}');
    print('Phone field: ${_phoneController.text}');
  }

  /*void _getlocation() async{
    var addresses = await Geocoder.local.findAddressesFromQuery(_addressController.text);
    var first = addresses.first;
    var location = first.coordinates.toMap();
    setState(() {
      _latitude = location['latitude'];
      _longitude = location['longitude'];
    });
    print(first.coordinates.toMap());
  }
*/
  String location = 'Null, Press Button';
  String Address = 'search';
  List<String> _values = [];
  List<bool> _selected = [];

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place
        .postalCode}, ${place.country}';
    setState(() {});}

  Widget buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _values.length; i++) {
      RawChip actionChip = RawChip(
        selected: _selected[i],
        label: Text(_values[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove class",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _selected[i] = !_selected[i];
          });
        },
        onDeleted: () {
          _values.removeAt(i);
          _selected.removeAt(i);

          setState(() {
            _values = _values;
            _selected = _selected;
          });
        },
        showCheckmark: false,
      );
      chips.add(actionChip);
      chips.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  Widget buildButtons() {
    List<Widget> buttons = [];

    for (int i = 1; i < 13; i++) {
      TextButton buttonChip = TextButton(
        style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              _values.add('class $i');
              _selected.add(true);
            });
          },
          child: Text("class $i", style: TextStyle(fontSize: 15,color: Colors.lightBlue),)
      );
      buttons.add(buttonChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }

    @override
    Widget build(BuildContext context) {
      var dropdownValue;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Your details", style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
          leading: Builder(
            builder: (context) =>
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded, color: Colors.black,),
                  onPressed: () => Navigator.pop(context),
                ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("First Name",
                      style: TextStyle(color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      hintStyle: TextStyle(fontSize: 14),
                      //border: UnderlineInputBorder(
                      //borderRadius: BorderRadius.circular(16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    //maxLines: 3,
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Last Name",
                      style: TextStyle(color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your Name",
                      hintStyle: TextStyle(fontSize: 14),
                      //border: UnderlineInputBorder(
                      //borderRadius: BorderRadius.circular(16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    //maxLines: 3,
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Mode",
                      style: TextStyle(color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  DropdownButtonFormField(
                    dropdownColor: Colors.white,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded, color: Colors.lightBlue,),
                    hint: Text("Choose a Mode"),
                    items: [
                      "Online",
                      "Offline",

                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                          style: TextStyle(fontSize: 14, color: Colors.black),),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print(newValue);

                    },
                    decoration: const InputDecoration(
                      enabled: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Address",
                      style: TextStyle(color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "address",
                      hintStyle: TextStyle(fontSize: 14),
                      //border: UnderlineInputBorder(
                      //borderRadius: BorderRadius.circular(16),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(fontSize: 14,),
                    //maxLines: 3,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                  Text('Coordinates Points',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text(location,style: TextStyle(color: Colors.black,fontSize: 16),),
                  SizedBox(height: 10,),
                  Text('ADDRESS',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text('${Address}'),
                  ElevatedButton(onPressed: () async {
                    Position position = await _determinePosition();

                    location =
                    'Lat: ${position.latitude} , Long: ${position.longitude}';

                    setState(() {

                    });
                    GetAddressFromLatLong(position);
                  }, child: Text('Get Location')
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Classes",
                      style: TextStyle(color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildChips(),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    child: buildButtons(),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),
                  /*const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Select the Class you prefer\n   ',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),

                  SizedBox(
                      height: 250,
                      child: FutureBuilder<List<TechStacks>>(
                        future: futures, // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TechStacks>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Text('Loading....');
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return GridView.builder(
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 1,
                                      // mainAxisExtent: 2,
                                      childAspectRatio: 2.0,
                                      crossAxisSpacing: 7,
                                      crossAxisCount: 3),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, int index) => InputChip(
                                    backgroundColor: Colors.white,
                                    /*backgroundColor: isSelected(index, indexs)
                                        ? Colors.lightBlue
                                        : Colors.white12,*/
                                    avatar: isSelected(index, indexs)
                                        ? const Icon(
                                      Icons.check_box_rounded,
                                      color: Colors.lightBlue,
                                      size: 20,
                                    )
                                        : const Icon(Icons.add),
                                    label: Text(
                                      '${snapshot.data![index].name!}',
                                      style: TextStyle(fontSize: 18,
                                        color: Colors.black,)/*isSelected(index, indexs)
                                          ? const TextStyle(
                                          fontSize: 18,
                                          color: Colors.lightBlue,
                                          //fontWeight: FontWeight.bold
                                          )
                                          : TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          //fontWeight: FontWeight.bold
                                          ),*/
                                    ),
                                    onSelected: (bool value) {
                                      selectedIndex = index;
                                      setState(() {
                                        (indexs.contains(index)
                                            ? indexs.remove(index)
                                            : indexs.add(index));
                                        _values.add('${snapshot.data![index].name!}');
                                        _selected.add(true);
                                      });
                                    },
                                  ),
                                );
                              }
                          }
                        },
                      )),*/
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          print(_values);
                          Future.delayed(Duration(seconds: 0), (){
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                title: Icon(Icons.check_circle, size: MediaQuery.of(context).size.height*0.125, color: Colors.lightBlue, shadows: [BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0,4),
                                )],
                                ),
                                actions: <Widget>[
                                  Column(
                                    children: [
                                      Text('Tutor Added Successfully !', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                      Row(
                                        children: [
                                          Spacer(),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Click here", style: TextStyle(fontSize: 14, fontFamily: 'poppins', color: Colors.lightBlue),)
                                          ),
                                          Text("to continue", style: TextStyle(fontSize: 14, fontFamily: 'poppins'),),
                                          Spacer(),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.lightBlue)
                                )
                            )
                        ),
                        child: Text("Add", style: TextStyle(fontSize: 14),)
                    ),
                  ),
              ]
          ),
        ),
        )     );
    }
  }


