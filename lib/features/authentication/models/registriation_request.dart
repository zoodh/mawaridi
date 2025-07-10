 class RegistrationRequest {
   final String mobileNumber;
   final String fullName;
   final String email;

  RegistrationRequest({
    required this.mobileNumber,
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'mobile_number': mobileNumber,
      'full_name': fullName,
      'email': email,
    };
  }
}
