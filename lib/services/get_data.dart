import 'package:corona_tracker/services/networking.dart';
import 'dart:async';


List currentStatus = [];
int confirmed;
  int deaths;
  int recovered;
  List dataList=[];
  int defaultValue = 000;

  
const CoronaDataUrl = "https://api.covid19india.org/v3/data.json";
class DataModel {

  Future<dynamic> getStateData(String stateName) async {
    NetworkHelper networkHelper = NetworkHelper(CoronaDataUrl);
    currentStatus.clear();
    var coronaData = await networkHelper.getData();
currentStatus.add(coronaData[stateName]["total"]["confirmed"]);
currentStatus.add(coronaData[stateName]["total"]["recovered"]);
currentStatus.add(coronaData[stateName]["total"]["deceased"]);
currentStatus.add(coronaData[stateName]["meta"]["last_updated"]);
    return currentStatus;
  }
  
}

class AutoSuggestion{
  
  Future<dynamic> getSearchData(String searchText,var lat ,var lon) async {

    NetworkHelper networkHelper = NetworkHelper(

"https://api.tomtom.com/search/2/search/$searchText.json?key=dyXYEvJ4GrBGjm0tAKCLKpTK7yOcc5Q8&limit=15&countrySet=IN&lat=$lat&lon=$lon&radius=10000&language=en-US&extendedPostalCodesFor=Addr%2CGeo%2CStr"
   
    );
    var searchData =await networkHelper.getData();
    //print(searchList.addAll(searchData[]zzz));
    
    Search search = Search.fromJson(searchData);

    //print(search.results[0].address.freeformAddress);
    //print(search.results[0].positions.lati);

      return search.results.toList();
   }
}

//Class that fetching results List from Search api 
class Search{
    final List<Results> results;
    Search({this.results});
    factory Search.fromJson(Map<String,dynamic> parsedJson){
        var list =parsedJson['results'] as List;
        List<Results> resultList =list.map((e) => Results.fromJson(e)).toList();
        return Search(
          results: resultList,
        );
    }
}

class Results{
  final  Address address;
  final  Positions positions;
  Results({this.address,this.positions});

  factory Results.fromJson(Map<String, dynamic> parsedJson){

   return Results(
     address: Address.fromJson(parsedJson['address']),
     positions: Positions.fromJson(parsedJson['position']),
   );
  }
}

class Address{
      final freeformAddress;
      Address({this.freeformAddress});
      factory Address.fromJson(Map<String,dynamic> parsedJson){
        return Address(
          freeformAddress: parsedJson['freeformAddress'],
          );
      }
}

class Positions{
  final  lati;
  final long;
  Positions({this.lati,this.long});
  factory Positions.fromJson(Map<String,dynamic> parsedJson){
    return Positions(
        lati: parsedJson['lat'],
        long: parsedJson['lon'],
    );
  }

}
