import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'form.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbyQaj_-KSd580k6ugmfirk9tOpiht9OWFZv3fX7oXZvK5aRwgh1cpGg_OvN-XVhlrQm/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      print(feedbackForm.toJson());
      await http
          .post(URL, body: convert.jsonEncode(feedbackForm.toJson()))
          .then((response) async {
        print(response.body);
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(STATUS_SUCCESS);
          });
        } else {
          callback("Failed");
        }
      });
    } catch (e) {
      print("error $e");
    }
  }

  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<FeedbackForm>> getFeedbackList() async {
    return await http.get(URL).then((response) {
      print(response.body);
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
    });
  }

  void deleteData(String number, void Function(String) callback) async {
    try {
      Map<String, dynamic> body = {"no": number, "req": "delete"};
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['no'] = number;
      data['req'] = "delete";
      print(data);
      await http.post(URL, body: data).then((response) async {
        print(response.body);
      });
    } catch (e) {
      print(e);
    }
  }
}
