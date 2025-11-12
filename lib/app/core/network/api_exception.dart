class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;

  /// ✅ Converts any thrown error into a clean readable message
  static String getErrorMessage(dynamic error) {
    if (error is ApiException) {
      return error.message; // custom thrown errors
    }

    if (error is FormatException) {
      return "Invalid data format";
    }

    if (error.toString().contains("SocketException")) {
      return "No internet connection";
    }

    if (error.toString().contains("Connection timed out")) {
      return "Connection timed out";
    }

    // Dio errors
    try {
      if (error.response != null && error.response.data != null) {
        if (error.response.data is Map && error.response.data["detail"] != null) {
          return error.response.data["detail"];
        }
      }
    } catch (_) {}

    return "Something went wrong, please try again.";
  }
}
