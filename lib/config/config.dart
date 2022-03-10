import 'package:flutter/material.dart';

class MyConfig {
  ///
  ///
  ///  [Read all the instructions carefully before editing any of the below]
  ///
  ///

  /// APP NAME
  ///This is your app name. You must change this name as your own app name. Currently the app name is
  /// [zCart].
  ///
  static const String appName = "appName";

  ///

  /// APP URLS
  /// This is your app url. You must change this url as your own app url. Currently the app url is
  /// [https://zcart.incevio.com].
  ///
  static const String appUrl = "https://beautyandessentials.shop/Matrimonixadmin/";

  ///

  ///App API URL
  ///This is your app api url. You must change this url as your own app api url. Currently the app api
  ///url is [https://test.incevio.com/api/]. This is the url that you will use to access the api. Don't ////forget the slash [/] at the end and [https://] at the front.
  ///
  static const String appApiUrl = 'https://beautyandessentials.shop/Matrimonixadmin/api/';

  ///

  /// APP COLORS
  /// These are your app colors. You must change this colors as your own app colors.
  ///Only change the hex values of the colors. Format of the color is [#FFFFFF].
  ///


  ///

  /// APP LOADING INDICATOR [OPTIONAL]
  /// This is your app loading indicator. You must change this loading indicator as your own app.
  /// Currently the app loading indicator is [SpinKitCubeGrid].
  /// You will find all the loading indicators in [SpinKit] package - [https://pub.dev/packages/flutter_spinkit]
  /// You just need to add the name of the indicator after [SpinKit]. For example here the name of the
  /// indicator is [CubeGrid]. So the complete name of the indicator is [SpinKitCubeGrid].
  ///


  ///

  /// TURN ON/OFF SWITCHABLE THEME AND SOCIAL LOGINS
  /// Currently all the values are set to [true]. You can change this to [false] if you want to turn off
  /// any of the theme and social logins.
  ///
  /// [true] means that the theme and social logins are enabled.
  /// [false] means that the theme and social logins are disabled.
  ///
  /// Social Logins
  /// FACEBOOK LOGIN
  static const bool isFacebookLoginActive = true;

  /// GOOGLE LOGIN
  static const bool isGoogleLoginActive = true;

  /// APPLE LOGIN [Not Yet Implemented]
  static const bool isAppleLoginActive = false;

  // Theme
  static const bool isDynamicThemeActive = true;

  ///

  /// PAYMENT GATEWAY CONFIGS
  /// These are your payment gateway configs. You must change this configs as your own payment gateway API configs. If you don't have any payment gateway API configs then you can leave these configs as it is.
  ///
  /// [RAZOR PAY]
  static const String device_token = 'AAAAZ8xb-oI:APA91bGw1_4enflqKMk7laZxMBYgPvkFlrSh8M8Ju1y4SnGpeQv2Bu8u7GbDBU4uuAQZduVNRpU86UgEcYUZGjcgC_HiULyAUoPeSE4lHOFjlIseAx9NkBfg8QhybRatMkFqI7Z-v8Ao';
  static const String razorPayApiKey = '';

  /// SECRET KEY
  static const String razorPaySecretKey = "";

  /// CURRENCY CODE
  static const String razorPayCurrency = "INR";

  /// [PAYSTACK]
  /// API KEY
  static const String paystackApiKey = '';

  /// PAYSTACK CURRENCY CODE
  static const String paystackCurrency = "ZAR";

  /// [PAYPAL]
  /// SANDBOX MODE [Change this to false if you want to use live mode]
  static const bool paypalSandboxMode = true;

  /// CLIENT ID
  static const String paypalClientId = "";

  /// CLIENT SECRET
  static const String paypalClientSecret = "";

  /// PAYPAL TRANSACTION DESCRIPTION [Change this description as your own]
  static const String paypalTransactionDescription = "Payment for ZCart";

  /// PAYPAL CURRENCY CODE
  static const String payPalCurrency = "USD";

  ///
  ///
  ///
  ///
  ///
  ///
  /// Dont change the code below
  MyConfig._();
}
