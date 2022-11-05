import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class review extends StatefulWidget {
  const review({Key? key}) : super(key: key);

  @override
  State<review> createState() => _reviewState();
}

class _reviewState extends State<review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding:EdgeInsets.fromLTRB(20, 30, 40, 50) ),

              RatingBar.builder(
                  initialRating: 3,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.all(8.0),
                  itemBuilder: (context,_)=>
                  Icon(Icons.star,color: Colors.black,),onRatingUpdate:(rating){
                print(rating);
              }
              )
            ],
          ),
        ),
      ),
    );
  }
}


