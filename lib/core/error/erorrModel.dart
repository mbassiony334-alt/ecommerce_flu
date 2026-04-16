import 'package:e_commarcae/core/services/api/endpoit.dart';

class ErorrModel {
  final String errorMessage;
  final String ? status;
  ErorrModel({required this.errorMessage, this.status});

  factory ErorrModel.fromJson(Map< String,dynamic> json) {
    return ErorrModel(errorMessage: json[ApiKey.errorMessage],status: json[ApiKey.status]);
  }
}
