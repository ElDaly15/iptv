// ErrorModel class to represent server errors.
class ErrorModel {
  final dynamic statusCode;
  final String errorMsg;
  final String code;

  ErrorModel({
    required this.statusCode,
    required this.errorMsg,
    required this.code,
  });

  factory ErrorModel.jsonData(dynamic jsonData) {
    return ErrorModel(
      statusCode: jsonData['status'] ?? 0,
      code: jsonData['code'] ?? 'UNKNOWN_CODE',
      errorMsg: jsonData['message'] ?? 'An unknown error occurred',
    );
  }
}
