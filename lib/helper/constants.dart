//Don't change anything here

/// Shared Pref
const String access = 'ACCESS';
const String loggedIn = 'LOGGED_IN';

///Hive
const String hiveBox = 'hive_box';
const String recentlyReviewedIds = 'recently_reviewed_ids';

/// Implemented payment methods

const String cod = 'cod';
const String wire = 'wire';
const String stripe = 'stripe';
const String paystack = 'paystack';
const String paypal = 'paypal-express';
const String razorpay = 'razorpay';

final List<String> paymentMethods = [
  cod,
  wire,
  stripe,
  // paystack,
  // paypal,
  // if (Platform.isAndroid) razorpay
];
