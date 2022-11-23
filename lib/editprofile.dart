import 'dart:io';


import 'package:editable_image/editable_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tute_me/profilewidget.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tute_me/textfield.dart';
import 'package:tute_me/user.dart';
import 'package:tute_me/userprefernce.dart';


class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  bool _showTypeButtons = false;
  bool _showModeButtons = false;
  bool _showSubjectList = false;
  bool _showChipButtons = false;
  bool _chipClassMade = false;
  bool _chipSubjectMade = false;
  bool _chipModeMade = false;
  bool _chipTypeMade = false;
  bool _loadingWidget = false;
  List<String> _values = [];
  List<bool> _selected = [];
  List<bool> _selectedMode = [];
  List<bool> _selectedType = [];
  List<dynamic> _subjects = [];
  List<dynamic> _mode = [];
  List<dynamic> _type = [];
  var subject_map = {};
  var class_map = {};
  var mode_map = {};
  var type_map = {};
  List<dynamic> items = [];
  List _searchResult = [];
  List<dynamic> _allSubjects = ["math","science","english","history","civics","economics"];

  List<dynamic> _modes = ['Online','Offline'];
  List<dynamic> _types = ['Group','Individual'];

  Widget buildClassChips() {
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
            _chipClassMade = true;
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
  Widget buildClassButtons() {
    List<Widget> buttons = [];

    for (int i = 1; i < 13; i++) {
      TextButton buttonChip = TextButton(
          style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              if (_values.contains('class $i') == false) {
                _values.add('class $i');
                _selected.add(true);
              }
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
  Widget buildTypeChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _type.length; i++) {
      RawChip actionChip = RawChip(
        selected: true,
        label: Text(_type[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove mode",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _chipTypeMade = true;
          });
        },
        onDeleted: () {
          setState(() {
            _type.removeAt(i);
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
  Widget buildTypeButtons() {
    List<Widget> buttons = [];

    for (int i = 0; i < 2; i++) {
      TextButton buttonChip = TextButton(
          style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              if (_type.contains(_types[i]) == false) {
                _type.add(_types[i]);
                _selectedType.add(true);
              }
            });
          },
          child: Text(_types[i], style: TextStyle(fontSize: 15,color: Colors.lightBlue),)
      );
      buttons.add(buttonChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }
  Widget buildModeChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _mode.length; i++) {
      RawChip actionChip = RawChip(
        selected: true,
        label: Text(_mode[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove mode",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _chipModeMade = true;
          });
        },
        onDeleted: () {
          setState(() {
            _mode.removeAt(i);
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
  Widget buildModeButtons() {
    List<Widget> buttons = [];

    for (int i = 0; i < 2; i++) {
      TextButton buttonChip = TextButton(
          style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              if (_mode.contains(_modes[i]) == false) {
                _mode.add(_modes[i]);
                _selectedMode.add(true);
              }
            });
          },
          child: Text(_modes[i], style: TextStyle(fontSize: 15,color: Colors.lightBlue),)
      );
      buttons.add(buttonChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }


  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = <dynamic>[];
    dummySearchList.addAll(_allSubjects);
    if(query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if(item.contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
        if(item.contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_allSubjects);
      });
    }
  }
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if(_values.length > 0)
      _chipClassMade = true;
    else
      _chipClassMade = false;
    /*if(_subjects.length > 0)
      _chipSubjectMade = true;
    else
      _chipSubjectMade = false;
    if(_mode.length > 0)
      _chipModeMade = true;
    else
      _chipModeMade = false;
    if(_type.length > 0)
      _chipTypeMade = true;
    else
      _chipTypeMade = false;*/
  }
  Widget profileImage = Image.asset('assets/iconbg.png', fit: BoxFit.fill,);
  var classEdit = TextEditingController();
  showAlertDialog(BuildContext context, TextEditingController _controller) {
    Widget launchButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        foregroundColor:  Color.fromARGB(
            232, 18, 215, 241),
      ),
      child: Text(
        'Ok',
        style: TextStyle(fontSize: 15),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actions: [
        TextField(
          controller: _controller,
        ),
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }
  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {pickImage(ImageSource.camera);

                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {pickImage(ImageSource.gallery);

                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  File? pickedImage;
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) =>
      Container(
        child: Builder(
          builder: (context) =>
              Scaffold(
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
                    title: Text('Edit your information'),
                    centerTitle: true),
                body: ListView(
                  padding: EdgeInsets.all(10),
                  physics: BouncingScrollPhysics(),
                  children: [


                    Column(
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width*0.2,
                          backgroundColor: Colors.transparent,
                          child: profileImage,
                        ),
                        IconButton(onPressed: () {
                        }, icon: Icon(Icons.add_a_photo_rounded, color: Color.fromARGB(
                            232, 18, 215, 241),), iconSize: 25,),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),


                    const SizedBox(height: 29),
                    Text("E-mail ID ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<E-mail ID>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {

                              showAlertDialog(context, classEdit);
                            }, icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),

                    ),
                    _chipClassMade ? Container(
                      height: MediaQuery.of(context).size.height*0.08,
                      child: buildClassChips(),
                    ) : Container(),
                    Text("Class: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<class>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {

                        }, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {
                              setState(() {
                                _showChipButtons = true;
                                _chipClassMade = true;
                              });
                              onSubmitted: (value) {
                                setState(() { _showChipButtons = false;});
                              };
                              showAlertDialog(context, classEdit);
                              _showChipButtons ? Container(
                                height: MediaQuery.of(context).size.height*0.08,
                                child: buildClassButtons(),
                              ) : Container();

                            }, icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        ),


                      ],
                    ),

                    Text("Subjects ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<Subjects>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {
                              setState(() {
                                _showSubjectList = true;
                              });

                              showAlertDialog(context, classEdit);

                            },

                              icon: Icon(Icons.edit), iconSize: 20,)

                            ,
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    _showSubjectList ?
                    Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height*0.3,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            width: MediaQuery.of(context).size.width*06,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if(_subjects.contains(items[index]) == false)
                                      _subjects.add(items[index]);
                                    print(_subjects);
                                    _chipSubjectMade = true;
                                  });
                                },
                                child: Text('${items[index]}'),
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                )
                            ),
                          );
                        },
                      ),
                    ) : Container(),
                    Text("Mode", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<Mode>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {
                              setState(() {
                                _showModeButtons = true;
                                _chipModeMade = true;
                              });

                              showAlertDialog(context, classEdit);
                            },
                              icon: Icon(Icons.edit), iconSize: 20,),

                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        ),
                        _showModeButtons ? Container(
                          height: MediaQuery.of(context).size.height*0.08,
                          child: buildModeButtons(),
                        ) : Container(),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),

                    ),
                    _chipTypeMade ? Container(
                      height: MediaQuery.of(context).size.height*0.08,
                      child: buildTypeChips(),
                    ) : Container(),

                    Text("Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<Type>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {
                              setState(() {
                                _showTypeButtons = true;
                                _chipTypeMade = true;
                              });

                              showAlertDialog(context, classEdit);
                            },
                              icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        ),
                        _showTypeButtons ? Container(
                          height: MediaQuery.of(context).size.height*0.08,
                          child: buildTypeButtons(),
                        ) : Container(),
                      ],
                    ),
                    Text("Fees", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<Fees>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {

                              showAlertDialog(context, classEdit);
                            }, icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        )
                      ],
                    ),
                    Text("Phone no", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<Phone no>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {

                              showAlertDialog(context, classEdit);
                            }, icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        )
                      ],
                    ),
                    Text("Area", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<Area>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {

                              showAlertDialog(context, classEdit);
                            }, icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        )
                      ],
                    ),
                    Text("About yourself", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<About yourself>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {

                              showAlertDialog(context, classEdit);
                            }, icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        )
                      ],
                    ),




                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(
                          232, 18, 215, 241),),
                        onPressed: (){
                          openImages();
                        },
                        child: Text("Open Images")

                    ),

                    Divider(),
                    Text("Picked Files:"),
                    Divider(),

                    imagefiles != null?Wrap(
                      children: imagefiles!.map((imageone){
                        return Container(
                            child:Card(
                              child: Container(
                                height: 100, width:100,
                                child: Image.file(File(imageone.path)),
                              ),
                            )
                        );
                      }).toList(),
                    ):Container()//

                  ],

                ),
              ),

        ),

      );
}







