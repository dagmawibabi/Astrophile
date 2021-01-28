import "dart:convert";
import 'package:http/http.dart';

class FetchData {
  Map instanceData;
  String apotdSD;
  String apotdHD;
  String title;
  String explanation;
  Future<void> getAPOTD(String date) async {
    Response instance = await get(
        "https://api.nasa.gov/planetary/apod?api_key=zJK3K5862ucPhhYeVlGyLaBU74QPV2dZ11XZS0gc&date=" +
            date.toString());
    instanceData = jsonDecode(instance.body);
    apotdSD = instanceData["url"];
    apotdHD = instanceData["hdurl"];
    title = instanceData["title"];
    explanation = instanceData["explanation"];
  }
}
