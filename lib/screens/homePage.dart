import 'package:corona_tracker/screens/markerformtest.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:corona_tracker/services/get_data.dart';
import 'package:corona_tracker/screens/googlemap.dart';
import 'package:corona_tracker/widgets/counter.dart';
import 'package:corona_tracker/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:corona_tracker/constant.dart';
import 'dart:core';
//import 'dart:async';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  DataModel data = DataModel();
  String dropDownValue = "Gujarat";
  String startingCaseData = "GJ";

  List stateName =  kDropDownMenuList.keys.toList();
  int confirmed;
  int deaths;
  int recovered;
  String last_update_Status;
  List dataList;

  @override
  void initState(){
    super.initState();
    controller.addListener(onScroll);
    changeCaseUpdate(startingCaseData);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

 
void changeCaseUpdate(dynamic stateName) async{
      
      dataList = await data.getStateData(stateName);
      print(dataList);
      setState(() {
     confirmed = (dataList == null) ? defaultValue : dataList[0];
     deaths = (dataList == null) ? defaultValue : dataList[2];
     recovered =  (dataList == null) ?  defaultValue: dataList[1];
      last_update_Status =  (dataList == null)? "We are Trying to fetch (...)":dataList[3];
    });    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: SafeArea(
              child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              MyHeader(
                image: "assets/icons/Drcorona.svg",
                textTop: "All you need",
                textBottom: "is stay at home.",
                offset: offset,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                    SizedBox(width: 20),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                        value: dropDownValue,
                        items:stateName.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropDownValue = newValue;
                           
                          });
                           changeCaseUpdate(kDropDownMenuList[newValue].toString());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Case Update\n",
                                style: kTitleTextstyle,
                              ),
                              TextSpan(
                                text: last_update_Status==null ? "Newest update:- Fetching... " :"Newest update:- ${last_update_Status.substring(0,10)}",
                                style: TextStyle(
                                  color: kTextLightColor,
                                ),
                              ),
                            
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),      
                     Align(
                       alignment: Alignment.centerLeft,
                                            child: Text(
                           last_update_Status==null ? "Time:- Fetching.....":"Time:- ${last_update_Status.substring(11,19)}",
                           style: TextStyle(
                                    color: kTextLightColor,
                                  ),
                                ),
                     ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Counter(
                            color: kInfectedColor,
                            number: confirmed,
                            title: "Infected",
                          ),
                          Counter(
                            color: kDeathColor,
                            number: deaths,
                            title: "Deaths",
                          ),
                          Counter(
                            color: kRecovercolor,
                            number: recovered,
                            title: "Recovered",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Spread of Virus",
                          style: kTitleTextstyle,
                        ),
                        Text(
                          "See details",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      height: 178,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: ()=>Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>MapPage())),
                        child: Image.asset(
                                     "assets/images/map.png",
                          fit: BoxFit.contain,
                        ),
                        
                      ),
                    ),
                  ],
                ),
              ),

              FloatingActionButton(
                child: Icon(Icons.add,size: 30,),
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MarkTest())),
                elevation: 15,
                
                )
                
            ],
          ),
          
        ),
      ),
    );
  }
}