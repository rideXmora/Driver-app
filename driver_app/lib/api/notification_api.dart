import 'package:driver_app/api/utils.dart';

Future<dynamic> subscribe({
  required String topic,
  required String token,
  required List<String> tokens,
}) async {
  String url = '/api/notification/subscribe';
  dynamic response = await postRequest(
    url: url,
    data: {
      "topicName": topic,
      "tokens": tokens,
    },
    token: token,
  );
  return response;
}

Future<dynamic> unsubscribe({
  required String topic,
  required String token,
  required List<String> tokens,
}) async {
  String url = '/api/notification/unsubscribe';
  dynamic response = await postRequest(
    url: url,
    data: {
      "topicName": topic,
      "tokens": tokens,
    },
    token: token,
  );
  return response;
}

Future<dynamic> topic({
  required String target,
  required String title,
  required String body,
  required String token,
}) async {
  String url = '/api/notification/topic';
  dynamic response = await postRequest(
    url: url,
    data: {
      "target": target,
      "title": title,
      "body": body,
    },
    token: token,
  );
  return response;
}

Future<dynamic> token({
  required String target,
  required String title,
  required String body,
  required String token,
}) async {
  String url = '/api/notification/token';
  dynamic response = await postRequest(
    url: url,
    data: {
      "target": target,
      "title": title,
      "body": body,
    },
    token: token,
  );
  return response;
}
