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

import 'details.dart';


class EditProfilePage2 extends StatefulWidget {
  @override
  _EditProfilePageState2 createState() => _EditProfilePageState2();
}

class _EditProfilePageState2 extends State<EditProfilePage2> {
  File? pickedImage;
  var nameEdit = TextEditingController();
  var classEdit = TextEditingController();

  Widget profileImage = Image.asset('assets/iconbg.png', fit: BoxFit.fill,);


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

                    /*CircleAvatar(
                      radius:MediaQuery.of(context).size.width*0.2,
                      backgroundColor: Colors.transparent,

                      child: pickedImage != null
                          ? Image.file(
                        pickedImage!,
                        fit: BoxFit.fill,
                      ),
                    ),*/
                    Column(
                      children: [

                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width*0.2,
                          backgroundColor: Colors.transparent,
                          child: pickedImage != null ? Image.file(
                            pickedImage!,
                            fit: BoxFit.fill,

                          )
                              : Image.asset('assets/iconbg.png', fit: BoxFit.fill,),

                        ),
                        Positioned(
                          bottom: 0,
                          right: 5,
                          child: IconButton(
                            onPressed:imagePickerOption,
                            icon: const Icon(
                              Icons.add_a_photo_rounded,
                              color: Color.fromARGB(
                                  232, 18, 215, 241),
                              size: 25,
                            ),
                          ),
                        ),



                        /* IconButton(onPressed: imagePickerOption, icon: Icon(

                          Icons.add_a_photo_rounded, color: Color.fromARGB(
                            232, 18, 215, 241),), iconSize: 25,),*/
                      ],
                    ),

                    const SizedBox(height: 24),
                    Text("Name: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<name>", style: TextStyle(fontSize:15),),
                        Spacer(),
                        TextButton(onPressed: () {}, child: Row(
                          children: [
                            const Text("Edit"),
                            IconButton(onPressed: () {
                              showAlertDialog(context, nameEdit);
                            }, icon: Icon(Icons.edit), iconSize: 20,),
                          ],
                        ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  232, 18, 215, 241),),
                            ))
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text("class: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Row(
                      children: [
                        Text("<class>", style: TextStyle(fontSize:15),),
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
                            ))
                      ],
                    ),


                  ],

                ),
              ),

        ),

      );
}







