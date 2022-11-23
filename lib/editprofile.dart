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
  List<String> _values = [];
  List<bool> _selected = [];
  bool _showChipButtons = false;
  bool _chipClassMade = false;
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
                    Text("Class: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<class>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
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
                            }, icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            )
                        ),
                        _showChipButtons ? Container(
                          height: MediaQuery.of(context).size.height*0.08,
                          child: buildClassButtons(),
                        ) : Container(),
                      ],
                    ),


                    /*const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Name',
                      text: user.name,
                      onChanged: (name) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Email ID',
                      text: user.email,
                      onChanged: (EmailID) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Subject',
                      text: user.Subject,

                      onChanged: (Subject) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Classes',
                      text: user.Classes,

                      onChanged: (Classes) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'PhoneNumber',
                      text: user.PhoneNumber,

                      onChanged: (PhoneNumber) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Address',
                      text: user.Address,
                      maxLines: 5,
                      onChanged: (Address) {},
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Fees',
                      text: user.Fees,

                      onChanged: (Fees) {},
                    ),*/
                    ElevatedButton(
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







