import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tute_me/textfield.dart';

class review extends StatefulWidget {
  const review({Key? key}) : super(key: key);

  @override
  State<review> createState() => _reviewState();
}

class _reviewState extends State<review> {
  TextEditingController _ratingController=TextEditingController();
  double rating=0;
  double rating1=0;
  double rating2=0;
  double rating3=0;
  double rating4=0;
  

  @override
  Widget build(BuildContext context) {

    var revieww;
    return Scaffold(
      appBar: AppBar(
        title: Text("Review",
        style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
      ),
      body: Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Padding(padding:EdgeInsets.fromLTRB(10.0,10.0,10.0,10.0) ),

              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Teacher Communication",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.02,),


              RatingBar.builder(

                  initialRating: 3,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Colors.blue,),onRatingUpdate:(rating)=>setState(() {

                this.rating1=rating; })

              ),
              Text('Your Rating: $rating1',
                style: TextStyle(fontSize: 20),),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Punctuality",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.02,),


              RatingBar.builder(

                  initialRating: 3,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Colors.blue,),onRatingUpdate:(rating)=>setState(() {

                this.rating2=rating; })

              ),
              Text('Your Rating: $rating2',
                style: TextStyle(fontSize: 20),),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Doubt Session",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.02,),


              RatingBar.builder(

                  initialRating: 3,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Colors.blue,),onRatingUpdate:(rating)=>setState(() {

                this.rating3=rating; })

              ),
              Text('Your Rating: $rating3',
                style: TextStyle(fontSize: 20),),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Delivery of structured lecture",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.02,),


              RatingBar.builder(

                  initialRating: 3,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Colors.blue,),onRatingUpdate:(rating)=>setState(() {

                this.rating4=rating; })

              ),
              Text('Your Rating: $rating4',
                style: TextStyle(fontSize: 20),),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Choose your Overall rating",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.02,),


              RatingBar.builder(

                  initialRating: 3,
                  minRating:1 ,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.all(8.0),
                  updateOnDrag: true,
                  itemBuilder: (context,_)=>
                      Icon(Icons.star,color: Colors.blue,),onRatingUpdate:(rating)=>setState(() {

                this.rating=rating; })

              ),
              Text('Your Rating: $rating',
                style: TextStyle(fontSize: 20),),
              const SizedBox(height: 32),





              Align(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                child: Text("Write your review",
                  style: TextStyle(color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              TextField(
                decoration: InputDecoration(
                  hintText: "your text here",
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



            ],
          ),
        ),
      ),
    );
  }
}


