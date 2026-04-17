import 'package:e_commarcae/core/services/api/endpoints.dart';

class ErrorModel {
  final String errorMessage;
  final String? status;

  ErrorModel({required this.errorMessage, this.status});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      errorMessage: json[ApiKey.errorMessage]?.toString() ?? 'Unknown error',
      status: json[ApiKey.status]?.toString(),
    );
  }
}

