import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_tracker/constant.dart';
import 'package:corona_tracker/services/get_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:core';


class MarkTest extends StatefulWidget {
  @override
  _MarkTestState createState() => _MarkTestState();
}

class _MarkTestState extends State<MarkTest> {
  List predictions = [];
  List prd = [];
  static Position currentlocation;

  @override
  void initState() {
    super.initState();
    getlocation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getlocation() async {
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      setState(() {
        currentlocation = value;
        print(currentlocation);
      });
    });
  }

  AutoSuggestion autoSuggestion = AutoSuggestion();

  void searchPrdict(String searchText, lat, lon) async {
    predictions.clear();
    List search = await autoSuggestion.getSearchData(searchText, lat, lon);
    if( search.length >= 1){
      myFlag =true;
      setState(() {
      for (int i = 0; i < search.length; i++) {
        predictions.add(search[i].address.freeformAddress);
        prd.add([search[i].positions.lati, search[i].positions.long]);
      }
    });
    }
    
  }

  final firestoreInstance = Firestore.instance;
  bool myFlag = false;
  bool enableText =true;

  void _onPressed(String name, double latitude, double longitude) {
    firestoreInstance.collection("marker_position").add({
      "name": name,
      "position": GeoPoint(latitude, longitude),
    }).then((value) {
      print(value.documentID);
    });
  }

  TextEditingController _controller = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: SafeArea(
        child: SingleChildScrollView(
                  child: Container(
            margin: EdgeInsets.only(right: 20, left: 20, top: 20),
            child: SizedBox(
              height: 1000,
                          child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    
                    controller: _controller,
                    enabled: enableText,
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      labelText: "Search Address",
                      hintText: "Enter Patient Address",
                        border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(),
                              ),
              
                    ),
                    
                    
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                    
                        if (value.length > 4) {
                          searchPrdict(value, currentlocation.latitude,
                              currentlocation.longitude);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  myFlag == true
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: predictions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Icon(
                                    Icons.pin_drop,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(predictions[index]),
                                onTap: () {
                                  setState(() {
                                    searchIndex = index;
                                    _controller.clear();
                                    enableText = false;
                                    myFlag = false;
                                  });
                                },
                              );
                            },
                          ),
                        )
                      : Container(
                    child:                       Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 1.0,
                      width: 170.0,
                      color: Colors.black,
                    ),
                  ),
                          ),
                  SizedBox(
                    height:20,
                  ),
                  Container(
                    child: Center(
                      child: Text("Fill Detail", style: kHeadingTextStyle),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 1.0,
                      width: 170.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Card(
                    elevation: 20,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.description),
                              fillColor: Color(0xFF262AAA),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(),
                              ),
                              hintText: 'enter Patient Name',
                              labelText: 'Name',
                            ),
                            onSubmitted: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                name = _nameController.text;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: searchIndex == null
                                ? Text("Selected Address :--------")
                                : Text(
                                    "Selected Address:- ${predictions[searchIndex]}"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FloatingActionButton.extended(
                            icon: Icon(Icons.forward),
                            onPressed: () {
                              print(prd[searchIndex]);
                              name = _nameController.text;
                              _onPressed(
                                  name, prd[searchIndex][0], prd[searchIndex][1]);
                              _controller.clear();
                              // _controller.dispose();
                              _nameController.clear();
                              predictions.clear();
                            },
                            label: Text("Submit"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int searchIndex;
  String name;
}
