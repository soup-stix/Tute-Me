
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:tute_me/cards.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/profile.dart';

class Listing extends StatefulWidget {
  const Listing({Key? key}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  final List _posts = [
    ["Kaichou wa Maid-Sama!","For Sale!!","https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1342630688l/15758313.jpg","300","Anand","123456798"],
    ["Da Vinci Code","Dan Brown","https://m.media-amazon.com/images/I/5171w-4D2FL.jpg","500","Anand","123456798"],
    ["IKIGAI","Japanese","https://images-na.ssl-images-amazon.com/images/I/81l3rZK4lnL.jpg","400","Anand","123456798"],
    ["Harry Potter and The Chamber of Secrets","JK Rowling","https://images-na.ssl-images-amazon.com/images/I/91HHqVTAJQL.jpg","700","Anand","123456798"],
    ["Rich Dad, Poor Dad","Robert T Kiyosaki","https://images-na.ssl-images-amazon.com/images/I/81bsw6fnUiL.jpg","1000","Anand","123456798"],
  ];
  List<String> items = [
    "Calculators",
    "Class Notes - Handwritten",
    "Engineering Graphics Tools",
    "Mini Drafters",
    "Non - Academics Books",
    "Observations",
    "Other PDF reference materials",
    "PDF Notes",
    "Previous year questions papers",
    "Reference Books",
    "Reference Materials - PDF",
    "Text Books",
    "Others",
  ];
  //var seen = Set<String>();
  //List<String> uniquelist = items.where((item) => seen.add(item)).toList();
  var categories;
  var negotiable;
  var delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add a listing", style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),
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
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Product name",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Give a title",
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
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Category",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.red,),
                  hint: Text("Choose a category"),
                  items: [
                    "Calculators",
                    "Class Notes - Handwritten",
                    "Engineering Graphics Tools",
                    "Mini Drafters",
                    "Non - Academics Books",
                    "Observations",
                    "Other PDF reference materials",
                    "PDF Notes",
                    "Previous year questions papers",
                    "Reference Books",
                    "Reference Materials - PDF",
                    "Text Books",
                    "Others",
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 14, color: Colors.black),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print(newValue);
                    categories = newValue;
                    print(categories);
                  },
                  decoration: const InputDecoration(
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Price",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter a price",
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
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Negotiable",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.red,),
                  hint: Text("Choose an option"),
                  items: ["Yes","No"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 14, color: Colors.black),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print(newValue);
                    negotiable = newValue;
                    print(negotiable);
                  },
                  decoration: const InputDecoration(
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Condition",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Briefly explain the condition of the product",
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
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Hand Over In",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.red,),
                  hint: Text("Choose a time period"),
                  items: ["1-3 days after connecting","4-7 days after connecting"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontSize: 14, color: Colors.black),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print(newValue);
                    delivery = newValue;
                    print(delivery);
                  },
                  decoration: const InputDecoration(
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Additional Info",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Mention any damage, Special features, Author names, contents of the products etc.',
                    hintMaxLines: 3,
                    hintStyle: TextStyle(fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    //border: //(BorderRadius.circular(8),),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          title: Icon(Icons.check_circle, size: MediaQuery.of(context).size.height*0.125, color: Colors.red, shadows: [BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0,4),
                          )],
                          ),
                          actions: <Widget>[
                            Column(
                              children: [
                                Text('Listing Added Successfully !', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                Row(
                                  children: [
                                    Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Click here", style: TextStyle(fontSize: 14, fontFamily: 'poppins', color: Colors.red),)
                                    ),
                                    Text("to continue", style: TextStyle(fontSize: 14, fontFamily: 'poppins'),),
                                    Spacer(),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.red)
                              )
                          )
                      ),
                      child: Text("List", style: TextStyle(fontSize: 14),)
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              ]
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.redAccent,
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
                    tooltip: "Cart",
                    icon: Icon(Icons.shopping_bag_outlined),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Sell",
                    icon: Icon(Icons.turned_in_rounded,),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Chat",
                    icon: Icon(Icons.textsms_outlined,),
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