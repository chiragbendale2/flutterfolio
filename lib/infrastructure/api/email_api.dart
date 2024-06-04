import 'dart:convert';
import 'dart:developer';

import 'package:flutterfolio/infrastructure/failures/email_failure.dart';
import 'package:flutterfolio/values/values.dart';
import 'package:http/http.dart' as http;

import 'email_model.dart';

abstract class EmailApi {
  ///portfolio-api-chi.vercel.app/api/getintouch
  Future<Email> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  });
}

class EmailApiImpl implements EmailApi {
  final http.Client client;

  EmailApiImpl({required this.client});

  @override
  Future<Email> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await client.post(
        Uri.parse(StringConst.BASE_URL + StringConst.GET_IN_TOUCH_POINT),
        body: jsonEncode({
          "name": name,
          "email": email,
          "subject": subject,
          "message": message,
        }),
      );

      if (response.statusCode == 200) {
        return Email(status: "success");
      } else {
        throw const EmailFailure.serverError();
      }
    } catch (e) {
      log("Errorss  ${e.toString()}");
      throw const EmailFailure.serverError();
    }
  }
}
