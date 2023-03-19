import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eco_waste/services/models/nearby_model.dart';
import 'package:eco_waste/services/models/waste_model.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  final String _nointernet = "No internet connection";
  final String _timeMsg = "Request timeout, connect to a better network";
  //final String msg = "An error occured: ";
  //static const String apiKey = "7c760c888117450f9ac628d1e86a7517";
  String wasteUrl =
      "https://newsapi.org/v2/everything?from=2023-03-10&to=2022-03-10&sortBy=relevancy&apiKey=7c760c888117450f9ac628d1e86a7517&searchIn=content&q=waste OR Plastics OR bin OR Recycle OR trash";
  // String appleUrl =
  //     "https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=$apiKey";

  Future<WasteModel> wasteApi() async {
    try {
      final response = await http.get(Uri.parse(wasteUrl)).timeout(
            const Duration(seconds: 60),
          );
      if (response.statusCode == 200) {
        var convert = json.decode(response.body);
        if (convert.toString().isNotEmpty && response.statusCode == 200) {
          WasteModel wasteModel = WasteModel.fromJson(convert);
          //print(wasteModel);
          return wasteModel;
        }
        return WasteModel.fromJson(jsonDecode(response.body));
      } else {
        return WasteModel(status: "Failed");
      }
    } on SocketException catch (_) {
      return WasteModel(status: "Failed");
    } on TimeoutException catch (_) {
      //return WasteModel(msg: _timeMsg, status: "Failed");
      return WasteModel(status: "Failed");
    } catch (e) {
      //return WasteModel(status: "Failed", msg: msg + '$e');
      return WasteModel(
        status: "Failed",
      );
    }
  }

  static Future<List<NearByModel>> getnearbyPlace(String latlng) async {
    String keyword = 'waste OR Waste management OR Bin OR Recycle OR Landfill';
    String location = '7.3218181 3.8472435';
    String radius = '15000';
    String type = 'waste';
    String key = 'AIzaSyB34FpSJSCaKaWqiDry0OVjrAPNIDFrcoA';
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$keyword&location=$location&radius=$radius&type=$type&key=$key'));
    final result = jsonDecode(response.body);
    final List nearby = result['results'];
    print(response.body);

    return nearby.map((e) => NearByModel.fromJson(e)).toList();
  }
}
