import 'dart:convert';

import 'package:covid_tracker_app/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

import '../Model/WorldStateModel.dart';


class StateServices{

  Future<WorldStateModel> fetchWorldStateRecords()async{
    final response = await http.get(Uri.parse(AppUrl.worldState));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    }
    else{
      throw Exception("Error");

    }

  }
  Future<List<dynamic>> countrieslistApi()async{

    final response = await http.get(Uri.parse(AppUrl.countryList));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("Error");
    }

  }

}