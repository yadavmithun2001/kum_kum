import 'package:kum_kum/config/config.dart';

class API {
  API._();
  static const String appName = MyConfig.appName;
  static const String appUrl = MyConfig.appUrl;

  /// Base URL
  //Point the API to the base URL
  static const base = MyConfig.appApiUrl;

  static const device_token = MyConfig.device_token;


  /// Payment Gateway Keys

  // Razorpay Configs
  static const String razorPayApiKey = MyConfig.razorPayApiKey;
  static const String razorPaySecretKey = MyConfig.razorPaySecretKey;
  static const String razorPayCurrency = MyConfig.razorPayCurrency;

  // Paystack Configs
  static const String paystackKey = MyConfig.paystackApiKey;
  static const String paystackCurrency = MyConfig.paystackCurrency;

  //Paypal Configs
  static const bool paypalSandboxMode = MyConfig.paypalSandboxMode;
  static const String paypalTransactionDescription =
      MyConfig.paypalTransactionDescription;
  static const String payPalCurrency = MyConfig.payPalCurrency;
  static const String paypalClientId = MyConfig.paypalClientId;
  static const String paypalClientSecret = MyConfig.paypalClientSecret;
  //

  //

  //

  /// User
  static const register = 'signup';
  static const login = 'login';
  static const loginUsingGoogle = 'auth/social/google';
  static const loginUsingFacebook = 'auth/social/facebook';
  static const loginUsingApple = 'auth/social/apple';
  static const logout = 'auth/logout';
  static const userInfo = 'userUpdate';
  static const updatePassword = 'password/update';
  static const setprofilepic = 'setProfileImage';
  static const setsliderimage1 = 'imageIn1';

  /// Forgot password & Reset
  static const forgot = 'auth/forgot';
  static const resetPasswordToken = 'auth/reset/token';
  static const resetPassword = 'auth/reset';

  /// Category
  static const category = 'category-grps';

  static categoryItem(String? slug) => 'listing$slug';

  static categorySubgroup(String categoryID) => 'category-subgrps/$categoryID';

  static subgroupCategory(String subgroupID) => 'categories/$subgroupID';

  /// Banner
  static const addvisitor = 'addVisitors';
  static const getvisitor = 'getVisitors';

  /// Slider
  static const slider = 'sliders';

  /// Tending Now
  static const trending = 'listings/trending';

  /// Recently Added Item
  static const latest = 'listings/latest';

  /// Popular Items
  static const popular = 'listings/popular';

  /// Random Items
  static const random = 'listings/random';

  /// Recently Viewed Items
  static const recentlyViewed = 'recently_viewed_items';

  /// Shops
  static const vendors = 'shops';

  static vendorDetails(String? slug) => 'shop/$slug';

  static vendorItem(String? slug) => 'shop/$slug/listings';

  static vendorFeedback(String slug) => 'shop/$slug/feedbacks';

  ///Brands
  static const brands = 'brands';

  static const featuredBrands = 'brands/featured';

  static brandProfile(String? slug) => 'brand/$slug';

  static brandItems(String? slug) => 'brand/$slug/listings';

  ///DEALS

  static const dealsUnderThePrice = 'deals/under-the-price';
  static const dealOfTheDay = 'deals/deal-of-the-day';

  /// Product Details
  static productDetails(String? slug) => 'listing/$slug';

  static productVariantDetails(String? slug) => 'variant/$slug';

  static productList(String slug) => 'listing/$slug';

  static offersFromOtherSeller(String? slug) => 'offers/$slug';

  /// Search
  static search(String searchedItem) => 'search/$searchedItem';

  /// Carts
  static const carts = 'carts';

  static cartItemDetails(cartId) => 'cart/$cartId';

  static addToCart(String? slug) => 'addToCart/$slug';

  static updateCart(int? itemID) => 'cart/$itemID/update';

  static removeCart(cart, item) => 'cart/removeItem?cart=$cart&item=$item';

  static const coupons = 'coupons';

  /// Coupon
  static applyCoupon(cartId, coupon) =>
      'cart/$cartId/applyCoupon?coupon=$coupon';

  /// Checkout
  static checkout(cartId) => 'cart/$cartId/checkout';

  /// Order
  static const orders = 'orders';

  static order(orderId) => 'order/$orderId';

  static orderReceived(orderId) => 'order/$orderId/goodsReceived';

  /// Wish List
  static const wishList = 'wishlist';

  static addToWishList(String? slug) => 'wishlist/$slug/add';

  static removeFromWishList(int? id) => 'wishlist/$id/remove';

  /// Address
  static const addresses = 'addresses';
  static const createAddress = 'address/store';

  static editAddress(addressId) => 'address/$addressId';
  static deleteAddress(addressId) => 'address/$addressId';

  /// Countries
  static const countries = 'countries';

  /// States
  static states(countryId) => 'states/$countryId';

  /// Packaging
  static packaging(shopSlug) => 'packaging/$shopSlug';

  /// Shipping options
  static shipping(shopId, zoneId) => 'shipping/$shopId?zone=$zoneId';

  static shippingOptions(id) => 'listing/$id/shipTo';

  /// Payment options
  static paymentOptions(cartId) => 'cart/$cartId/paymentOptions';

  /// Dispute
  static const disputes = 'disputes';

  static disputeInfo(orderId) => 'order/$orderId/dispute';
  static disputeDetails(disputeId) => 'dispute/$disputeId';

  static openDispute(orderId) => 'order/$orderId/dispute';
  static markAsSolved(disputeId) => 'dispute/$disputeId/solved';

  static getDisputeResponse(disputeId) => 'dispute/$disputeId/response';
  static responseDispute(disputeId) => 'dispute/$disputeId/response';
  static appealDispute(disputeId) => 'dispute/$disputeId/appeal';

  /// Blog
  static const blogs = 'blogs';
  static blog(slug) => 'blog/$slug';

  /// Feedback
  static sellerFeedback(orderId) => 'shop/$orderId/feedback';
  static productFeedback(orderId) => 'order/$orderId/feedback';

  /// Order - Chat
  static orderConversation(orderId) => 'order/$orderId/conversation';
  static orderSendMessage(orderId) => 'order/$orderId/conversation';

  /// Product - Chat
  static productConversation(shopId) => 'shop/$shopId/contact';
  static productSendMessage(shopId) => 'shop/$shopId/contact';

  /// Conversation
  static const conversations = 'conversations';

  ///Plugins
  static checkPluginAvailability(pluginSlug) => 'plugin/$pluginSlug';
  static const flashDealPlugin = "deals/flash-deals";

  ///Others
  static const aboutUs = 'page/about-us';
  static const privacyPolicy = 'page/privacy-policy';
  static const termsAndCondition = 'page/terms-of-use-merchant';
}
