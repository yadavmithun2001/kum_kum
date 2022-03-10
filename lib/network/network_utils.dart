import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:kum_kum/helper/constants.dart';

import 'api.dart';

const noInternetMsg = 'You are not connected to Internet';
const errorMsg = 'Please try again later.';

/// Variables
bool accessAllowed = false;

bool isSuccessful(int code) {
  return code >= 200 && code <= 206;
}

Future<Response> getRequest(String? endPoint,
    {bool bearerToken = false, bool noBaseUrl = false}) async {
  if (await isNetworkAvailable()) {
    Map<String, String>? headers;
    Response response;
    var accessToken = getStringAsync(access);

    if (bearerToken) {
      headers = {
        HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
        "Authorization": "Bearer $accessToken"
      };
    }

    if (!noBaseUrl) {
      debugPrint('URL: ${API.base}$endPoint');
    } else {
      debugPrint('URL: $endPoint');
    }
    //debugPrint('Header: $headers');

    if (bearerToken) {
      response = await get(Uri.parse('${API.base}$endPoint'), headers: headers);
    } else if (noBaseUrl) {
      response = await get(Uri.parse('$endPoint'));
    } else {
      response = await get(Uri.parse('${API.base}$endPoint'));
    }

    //debugPrint('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}

postRequest(String endPoint, Map? requestBody,
    {bool bearerToken = false, bool noBaseUrl = false}) async {
  if (await isNetworkAvailable()) {
    Response? response;
    if (!noBaseUrl) {
      debugPrint('URL: ${API.base}$endPoint');
    } else {
      debugPrint('URL: $endPoint');
    }
    debugPrint('body: $requestBody');

    var accessToken = getStringAsync(access);

    var headers = {
      HttpHeaders.contentTypeHeader : 'application/x-www-form-urlencoded',
      HttpHeaders.acceptLanguageHeader : 'en',
      HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    };

    if (bearerToken) {
      var header = {"Authorization": "Bearer $accessToken"};
      headers.addAll(header);
    }

    debugPrint("Headers: $headers");
    try {
      if (!noBaseUrl) {
        response = await post(Uri.parse('${API.base}$endPoint'),
            body: requestBody, headers: headers);
      } else {
        response = await post(Uri.parse(endPoint),
            body: requestBody, headers: headers);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    //debugPrint('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}

putRequest(String endPoint, Map request, {bool bearerToken = true}) async {
  if (await isNetworkAvailable()) {
    late Response response;
    debugPrint('URL: ${API.base}$endPoint');
    debugPrint('Request: $request');

    var accessToken = getStringAsync(access);

    var headers = {
      HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    };

    if (bearerToken) {
      var header = {"Authorization": "Bearer $accessToken"};
      headers.addAll(header);
    }

    debugPrint("Headers: $headers");
    try {
      response = await put(Uri.parse('${API.base}$endPoint'),
          body: request, headers: headers);
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}

// multiPartRequest(String endPoint, Map body,
//     {File? file, String? filename, bool bearerToken = true}) async {
//   if (await isNetworkAvailable()) {
//     ///MultiPart request
//     var request = MultipartRequest(
//       'PUT',
//       Uri.parse('${API.base}$endPoint'),
//     );

//     var accessToken = getStringAsync(access);

//     var headers = {
//       HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
//     };

//     if (bearerToken) {
//       var header = {
//         "Authorization": "Bearer $accessToken",
//         "Content-type": "application/json",
//       };

//       headers.addAll(header);
//     }

//     if (file != null && filename != null) {
//       request.files.add(
//         MultipartFile(
//           'profile_image',
//           file.readAsBytes().asStream(),
//           file.lengthSync(),
//           filename: filename,
//           contentType: MediaType('image', 'jpeg'),
//         ),
//       );
//     }

//     request.headers.addAll(headers);
//     request.fields.addAll(body as Map<String, String>);

//     debugPrint('Request: $request');
//     StreamedResponse streamedResponse = await request.send();
//     Response response = await Response.fromStream(streamedResponse);
//     debugPrint('Response: ${response.statusCode} ${response.body}');
//     return response;
//   } else {
//     throw noInternetMsg;
//   }
// }

patchRequest(String endPoint, Map request,
    {bool requireToken = false,
      bool bearerToken = false,
      bool isDigitToken = false}) {}

deleteRequest(String endPoint, {bool bearerToken = true}) async {
  if (await isNetworkAvailable()) {
    var accessToken = getStringAsync(access);
    debugPrint('URL: ${API.base}$endPoint');

    var headers = {
      HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
    };

    if (bearerToken) {
      var header = {"Authorization": "Bearer $accessToken"};
      headers.addAll(header);
    }

    debugPrint(headers.toString());
    Response response =
    await delete(Uri.parse('${API.base}$endPoint'), headers: headers);
    debugPrint('Response: ${response.statusCode} ${response.body}');
    return response;
  } else {
    throw noInternetMsg;
  }
}

Future handleResponse(Response response, {bool showToast = true}) async {
  if (!await isNetworkAvailable()) {
    throw noInternetMsg;
  }
  if (isSuccessful(response.statusCode)) {
    if (response.body.isNotEmpty) {
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return jsonDecode(response.body);
    } else {
      return response.body;
    }
  } else {
    if (response.body.isJson()) {
      debugPrint("handleResponse (json): ${jsonDecode(response.body)}");
      if (jsonDecode(response.body)['errors'] != null) {
        toast(
          jsonDecode(response.body)['errors']
          [jsonDecode(response.body)['errors'].keys.first][0],
        );
      } else if (showToast) {
        toast(
          jsonDecode(response.body)['message'] ??
              jsonDecode(response.body)['error'],
        );
      }

      if (response.statusCode == 401) {
        toast(response.body.toString());
      }
      return response.statusCode;
    } else {
      try {
        debugPrint("handleResponse: ${jsonDecode(response.body)}");
      } catch (e) {
        debugPrint(response.body);
        return 500;
      }
      return response.statusCode;
    }
  }
}
