


import 'package:dio/dio.dart';

Future<dynamic> sendMessage(String message) async {
  String botToken = "6273173896:AAG0In5Yvqc2lCs190ADN0qyT3_3zJ8CKyg";
  String groupId = "-809090373";
  final encodedMessage = Uri.encodeComponent(message);
  final url =
      "https://api.telegram.org/bot$botToken/sendMessage?chat_id=$groupId&text=$encodedMessage";

  try {
    final response = await Dio().post(url);
    return response.data;
  } catch (error, stackTrace) {
    print('Error: $error');
    print('Stack trace: $stackTrace');
    throw error;
  }
}