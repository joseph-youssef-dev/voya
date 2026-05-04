class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map jsonData) {
    String message = "Unknown Error";
    final errorsData = jsonData["errors"] ?? jsonData["Errors"];
    if (errorsData != null) {
      if (errorsData is Map) {
        final buffer = StringBuffer();
        errorsData.forEach((key, value) {
          if (value is List) {
            buffer.writeln(value.join(", "));
          } else {
            buffer.writeln(value.toString());
          }
        });
        message = buffer.toString().trim();
      } else if (errorsData is List) {
        message = errorsData.join("\n").trim();
      } else {
        message = errorsData.toString();
      }
    } else {
      message = jsonData["Message"]?.toString() ?? 
                jsonData["message"]?.toString() ?? 
                jsonData["title"]?.toString() ?? 
                "Unknown Error";
    }

    return ErrorModel(
      errorMessage: message,
      status: jsonData["status"] ?? jsonData["statusCode"] ?? 000,
    );
  }
}
