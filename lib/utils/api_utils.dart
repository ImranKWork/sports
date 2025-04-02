class ApiUtils {
  static final BASE_URL =
      "https://urgd9n1ccg.execute-api.us-east-1.amazonaws.com";

  // header
  static const String AUTHORIZATION = "Authorization";
  static const String CONTENT_TYPE = "Content-Type";
  static const String ACCEPT = "Accept";
  static const String HEADER_TYPE = "application/json";
  static const String USER_AGENT = "user-agent";
  static const String X_PLATFORM = "x-platform";
  static const String METADATA = "metadata";
  static const String DEVICE_TOKEN = "device_token";
  static const String DEVICE_ID = "device_id";

  //common
  static const String ID = "id";
  static const String UDID = "udid";
  static const String CURRENT_STATUS_VALUE = "current_status_value";
  static const String UDID_VALUE = "udid_value";
  static const String DEVICE_TYPE = "device_type";

  static const String NAME = "name";
  static const String METAL_NAME = "metal_name";

  static const String DEVICE_DETAILS = "device?udid=${UDID_VALUE}";
  static const String REGISTER_DEVICE = "device";
}
