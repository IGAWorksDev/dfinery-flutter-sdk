/// Callback class used when retrieving Google Advertising ID information.
///
/// This class contains the Google Advertising ID and the associated
/// limit ad tracking preference for the current device.
class DFGetGoogleAdvertisingIdCallback {
  /// Advertising ID.
  final String _googleAdvertisingId;

  /// Whether the user has limit ad tracking enabled or not.
  final bool _isLimitAdTrackingEnabled;

  /// Creates a callback with Google Advertising ID information.
  ///
  /// [googleAdvertisingId] The device's Google Advertising ID.
  /// [isLimitAdTrackingEnabled] Whether limit ad tracking is enabled.
  DFGetGoogleAdvertisingIdCallback(
      this._googleAdvertisingId, this._isLimitAdTrackingEnabled);

  /// Retrieves the advertising ID.
  String get googleAdvertisingId => _googleAdvertisingId;

  /// Retrieves whether the user has limit ad tracking enabled or not.
  bool get isLimitAdTrackingEnabled => _isLimitAdTrackingEnabled;
}
