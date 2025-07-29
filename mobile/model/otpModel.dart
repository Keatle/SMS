class OTPResponseModel {
  final String? success; 
  final String? error;    

  OTPResponseModel({this.success, this.error});

 
  factory OTPResponseModel.fromJson(Map<String, dynamic> json) {
    return OTPResponseModel(
      success: json['success'] as String?, 
      error: json['error'] as String?,      
    );
  }
}
