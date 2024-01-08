// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

class SendNotification {
  static var SERVER_KEY = "AAAAYFlyFlU:APA91bFtL0YkQDwghSqYpTJDa1Sqv5k9_IJqc_ZZN0hoe-frGXrl5_ymgWKNy07UvkKXkMA3-L-sc8Fyq_97CSmHLPuHoZ4IVPV3Wb5mHgZvpwefs6UWTEWwzijh09qZ3ks1ZRSxWcfj";

  static sendMessageNotification(String token, String title, String body, Map<String, dynamic>? payload) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$SERVER_KEY',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': payload ?? <String, dynamic>{},
          'to': token
        },
      ),
    );
  }
}
