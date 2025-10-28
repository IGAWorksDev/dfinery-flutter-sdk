/// A collection of constants for predefined event names in Dfinery.
class DFEvent {
  /// Reports events when a user logs in.
  static const String login = 'df_login';

  /// Reports events when a user logs out.
  static const String logout = 'df_logout';

  /// Reports events in which users sign up for membership.
  static const String signUp = 'df_sign_up';

  /// Reports events in which a user pays for a product.
  static const String purchase = 'df_purchase';

  /// Reports events in which a user canceled an order or issued a refund.
  static const String refund = 'df_refund';

  /// Reports events where the user enters the app's home (main) screen.
  static const String viewHome = 'df_view_home';

  /// Reports events when a user views product details.
  static const String viewProductDetail = 'df_view_product_details';

  /// Reports events in which users add products to their shopping carts.
  static const String addToCart = 'df_add_to_cart';

  /// Reports events in which users add products to their list of products of interest.
  static const String addToWishList = 'df_add_to_wishlist';

  /// Reports events in which users search for products.
  static const String viewSearchResult = 'df_view_search_result';

  /// Reports events in which users share product information.
  static const String shareProduct = 'df_share_product';

  /// Reports events in which users view product lists.
  static const String viewList = 'df_view_list';

  /// Reports events in which users view their shopping carts.
  static const String viewCart = 'df_view_cart';

  /// Reports events in which users remove items from their shopping carts.
  static const String removeCart = 'df_remove_cart';

  /// Reports events in which users enter payment information.
  static const String addPaymentInfo = 'df_add_payment_info';
}

/// A collection of constants for predefined event properties in Dfinery.
class DFEventProperty {
  /// Key value of an array containing products.
  static const String items = 'df_items';

  /// Product ID. This property should be placed within items array.
  static const String itemId = 'df_item_id';

  /// Product name. This property should be placed within items array.
  static const String itemName = 'df_item_name';

  /// Product price. This property should be placed within items array.
  static const String itemPrice = 'df_price';

  /// Product quantity. This property should be placed within items array.
  static const String itemQuantity = 'df_quantity';

  /// Product discount amount. This property should be placed within items array.
  static const String itemDiscount = 'df_discount';

  /// Product category level 1. This property should be placed within items array.
  static const String itemCategory1 = 'df_category1';

  /// Product category level 2. This property should be placed within items array.
  static const String itemCategory2 = 'df_category2';

  /// Product category level 3. This property should be placed within items array.
  static const String itemCategory3 = 'df_category3';

  /// Product category level 4. This property should be placed within items array.
  static const String itemCategory4 = 'df_category4';

  /// Product category level 5. This property should be placed within items array.
  static const String itemCategory5 = 'df_category5';

  /// Total refund amount for refund events.
  static const String totalRefundAmount = 'df_total_refund_amount';

  /// Order ID for purchase events.
  static const String orderId = 'df_order_id';

  /// Discount amount for purchase events.
  static const String discount = 'df_discount';

  /// Delivery charge for purchase events.
  static const String deliveryCharge = 'df_delivery_charge';

  /// Payment method for purchase events.
  static const String paymentMethod = 'df_payment_method';

  /// Total purchase amount for purchase events.
  static const String totalPurchaseAmount = 'df_total_purchase_amount';

  /// Sharing channel for share product events.
  static const String sharingChannel = 'df_sharing_channel';

  /// Sign up channel for sign up events.
  static const String signChannel = 'df_sign_channel';

  /// Search keyword for view search result events.
  static const String keyword = 'df_keyword';
}

/// A collection of constants for predefined user profile names in Dfinery.
class DFUserProfile {
  /// User's name.
  static const String name = 'df_name';

  /// User's gender.
  static const String gender = 'df_gender';

  /// User's date of birth. The format must be "yyyy-MM-dd".
  static const String birth = 'df_birth';

  /// User's membership information.
  static const String membership = 'df_membership';

  /// Whether the user consents to receiving text messages for advertisements.
  static const String smsAdsOptin = 'df_sms_ads_optin';

  /// Whether the user agrees to receive Kakao AlimTalk for advertisements.
  static const String kakaoAdsOptin = 'df_kakao_ads_optin';

  /// Whether the user consents to receiving push notifications for advertisements.
  static const String pushAdsOptin = 'df_push_ads_optin';

  /// Whether the user consents to receiving push notifications for advertisements at night.
  static const String pushNightAdsOptin = 'df_push_night_ads_optin';
}

/// A collection of constants for predefined gender values in Dfinery.
class DFGender {
  /// Value meaning male.
  static const String male = 'Male';

  /// Value meaning female.
  static const String female = 'Female';

  /// Value meaning non binary.
  static const String nonBinary = 'NonBinary';

  /// Value meaning other.
  static const String other = 'Other';
}

/// DfineryConfig is used to apply configuration items to the SDK.
class DFConfig {
  /// Enables iOS logging.
  static const String iosLogEnable = "df_config_log_enable";

  /// Enables Android logging.
  static const String androidLogEnable = "android_log_enable";

  /// Sets Android log level.
  static const String androidLogLevel = "android_log_level";

  /// Sets Android notification small icon.
  static const String androidNotificationIconName =
      "android_notification_icon_name";

  /// Sets Android default notification channel ID.
  static const String androidNotificationChannelId =
      "android_notification_channel_id";

  /// Sets Android notification accent color. Must be entered in color hex string format.
  static const String androidNotificationAccentColor =
      "android_notification_accent_color";
}

/// Android log level. Definition follows the constant of android.util.Log.
class DFAndroidLogLevel {
  /// @see https://developer.android.com/reference/android/util/Log#VERBOSE
  static const int verbose = 2;

  /// @see https://developer.android.com/reference/android/util/Log#DEBUG
  static const int debug = 3;

  /// @see https://developer.android.com/reference/android/util/Log#INFO
  static const int info = 4;

  /// @see https://developer.android.com/reference/android/util/Log#WARN
  static const int warn = 5;

  /// @see https://developer.android.com/reference/android/util/Log#ERROR
  static const int error = 6;

  /// @see https://developer.android.com/reference/android/util/Log#ASSERT
  static const int assertLevel = 7;
}

/// Attribute values to be used when creating an Android notification channel.
class DFAndroidNotificationChannelProperty {
  /// @see https://developer.android.com/reference/android/app/NotificationChannel#getId()
  static const String id = "id";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#setName(java.lang.CharSequence)
  static const String name = "name";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#setDescription(java.lang.String)
  static const String description = "description";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#setShowBadge(boolean)
  static const String badge = "badge";

  /// Choose whether to play notification sounds in the notification channel.
  static const String sound = "sound";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#setSound(android.net.Uri,%20android.media.AudioAttributes)
  static const String soundUri = "soundUri";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#setImportance(int)
  static const String importance = "importance";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#shouldShowLights()
  static const String lights = "lights";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#shouldVibrate()
  static const String vibration = "vibration";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#getLockscreenVisibility()
  static const String visibility = "visibility";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#setBypassDnd(boolean)
  static const String bypassDnd = "bypassDnd";

  /// @see https://developer.android.com/reference/android/app/NotificationChannel#setGroup(java.lang.String)
  static const String groupId = "groupId";
}

/// Attribute values to be used when creating an Android notification channel group.
class DFAndroidNotificationChannelGroupProperty {
  /// @see https://developer.android.com/reference/android/app/NotificationChannelGroup#getId()
  static const String id = "id";

  /// @see https://developer.android.com/reference/android/app/NotificationChannelGroup#getName()
  static const String name = "name";
}

/// The amount the user should be interrupted by notifications from this channel.
class DFAndroidNotificationChannelImportance {
  /// @see https://developer.android.com/reference/android/app/NotificationManager#IMPORTANCE_NONE
  static const int none = 0;

  /// @see https://developer.android.com/reference/android/app/NotificationManager#IMPORTANCE_MIN
  static const int min = 1;

  /// @see https://developer.android.com/reference/android/app/NotificationManager#IMPORTANCE_LOW
  static const int low = 2;

  /// @see https://developer.android.com/reference/android/app/NotificationManager#IMPORTANCE_DEFAULT
  /// Note: 'default' is a reserved keyword, so 'defaultImportance' is used instead.
  static const int defaultImportance = 3;

  /// @see https://developer.android.com/reference/android/app/NotificationManager#IMPORTANCE_HIGH
  static const int high = 4;

  /// @see https://developer.android.com/reference/android/app/NotificationManager#IMPORTANCE_MAX
  static const int max = 5;
}

/// Controls notification visibility on lockscreens and during screen sharing.
/// Shows notification on all lockscreens, but conceals sensitive or private information on secure lockscreens.
class DFAndroidNotificationChannelVisibility {
  /// @see https://developer.android.com/reference/android/app/Notification#VISIBILITY_PUBLIC
  static const int public = 1;

  /// @see https://developer.android.com/reference/android/app/Notification#VISIBILITY_PRIVATE
  static const int private = 0;

  /// @see https://developer.android.com/reference/android/app/Notification#VISIBILITY_SECRET
  static const int secret = -1;
}
