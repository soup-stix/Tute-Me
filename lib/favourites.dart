import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tute_me/details.dart';
import 'package:firebase_database/firebase_database.dart';

class MyFavourites extends StatefulWidget{
  final child;

  const MyFavourites({Key? key, required this.child}) : super(key: key);

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  final _database = FirebaseDatabase.instance.reference();
  dynamic _data;
  Future<dynamic> _get_details() async{
    _data = await _database.child('Teachers/${widget.child}').get();
    print(_data.value);
  }

  @override
  Widget build(BuildContext context) {
    _get_details();
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.2,
          child: MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Details(child: _data.value)));
            },
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage("assets/gajju.jpg"),//NetworkImage(child[2]),
                          fit: BoxFit.fill,
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.35,
                                  child: Text(_data.value['first_name']+" "+_data.value['last_name'],
                                    style: TextStyle(fontSize: 25,),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: 5,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      direction: Axis.horizontal,
                                    ),
                                    Text("/ 300 reviews",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(fontSize: 15,),),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.5,
                                  child: Text("Rs. "+_data.value['fee'].toString(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(fontSize: 20,),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              height: 150,
            ),
          ),
        ),
      ],
    );
  }
}