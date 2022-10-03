import 'package:flutter/material.dart';
//import 'package:resale_test_1/flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/listingnew.dart';


class Details extends StatefulWidget {
  final List child;
  const Details({Key? key, required this.child}) : super(key: key);

  @override
  DetailsState createState() => DetailsState();
  }

  class DetailsState extends State<Details> {
    PageController? pageViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.lightBlueAccent,
    appBar: AppBar(
      title: Text(widget.child[0],style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
    leading: Builder(
    builder: (context) =>
    IconButton(
    icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
    onPressed: () => Navigator.pop(context),
    ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          //SizedBox(height: MediaQuery.of(context).size.height*0.05,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-0.7, 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.35,
                          width: MediaQuery.of(context).size.width*0.90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.transparent,
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: PageView(
                                  controller: pageViewController ??=
                                      PageController(initialPage: 0),
                                  scrollDirection: Axis.horizontal,
                                  children:[
                                    Image.asset(
                                      'assets/mia.jpg',
                                      //width: 100,
                                      //height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.network(
                                      'assets/sins.jpg',
                                      //width: 100,
                                      //height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.network(
                                      'assets/gajju.jpg',
                                      //width: 100,
                                      //height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  child: SmoothPageIndicator(
                                    controller: pageViewController ??=
                                        PageController(initialPage: 0),
                                    count: 3,
                                    axisDirection: Axis.horizontal,
                                    onDotClicked: (i) {
                                      pageViewController!.animateToPage(
                                        i,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    },
                                    effect: ExpandingDotsEffect(
                                      expansionFactor: 2,
                                      spacing: 8,
                                      radius: 8,
                                      dotWidth: 8,
                                      dotHeight: 8,
                                      dotColor: Color(0xFF9E9E9E),
                                      activeDotColor: Color(0xFF3F51B5),
                                      paintStyle: PaintingStyle.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width*0.90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(child[2]),fit: BoxFit.fill,),
                      ),
                      ),*/
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      Align(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                        child: Text("Rs. "+widget.child[3],
                          style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.35),
                        child: Text('Negotiable *',
                          style: TextStyle(color: Colors.black,fontSize: 12,),
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
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      Text("Good Condition, neatly maintained",
                        style: TextStyle(fontSize: 14,),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      Align(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                        child: Text("Hand Over in",
                          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      Text("1-3 days after connecting",
                        style: TextStyle(fontSize: 14,),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                      Align(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                        child: Text("Additional Info",
                          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black,),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("1-3 days after connecting",
                            style: TextStyle(fontSize: 14,),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      Align(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                        child: Text("Sold By",
                          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                      Align(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                        child: Text("Anand",
                          style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlueAccent,
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

                    },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Home",
                    icon: Icon(Icons.home_rounded),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Map())),
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Locate",
                    icon: Icon(Icons.location_on_outlined,),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile())),
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
