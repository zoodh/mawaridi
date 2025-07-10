class LoginRequest {
  final String mobileNumber;
  final String otp;

  LoginRequest({
    required this.mobileNumber,
    required this.otp
  });

  Map<String, dynamic> toJson() {
    return {
      'mobile_number': mobileNumber,
      'otp' : otp,
    };
  }
}
