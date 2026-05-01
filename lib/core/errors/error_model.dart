class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map jsonData) {
    String message = "Unknown Error";
    
    if (jsonData["errors"] != null && jsonData["errors"] is Map) {
      final errors = jsonData["errors"] as Map;
      final buffer = StringBuffer();
      errors.forEach((key, value) {
        if (value is List) {
          buffer.writeln("${value.join(", ")}");
        } else {
          buffer.writeln("$value");
        }
      });
      message = buffer.toString().trim();
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
