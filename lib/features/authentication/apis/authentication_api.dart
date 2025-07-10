import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/app/logic/remote_client_provider.dart';
import 'package:mawaridii/features/authentication/models/login_request.dart';
import 'package:mawaridii/features/authentication/models/registriation_request.dart';

import '../models/user.dart';
final authApiProvider = Provider<IAuthApi>((ref) => _AuthApi(ref));

abstract interface class IAuthApi {
  Future<User> register(RegistrationRequest registerRequest);
  Future<User> login(LoginRequest loginRequest);
  Future<void> resendOTP();
  Future<bool> verifyOTP(String userId, String otp);
}


class _AuthApi implements IAuthApi {
  final Ref ref;

  _AuthApi(this.ref);

  @override
  Future<User> login(LoginRequest loginRequest) async {
    try {
      final response = await ref.read(remoteClientProvider).post(
        "dummyapirequest",
        data: loginRequest.toJson(),
      );

      // Parse user from response
      final user = User.fromJson(response.data);

      // Verify OTP
      final isOtpCorrect = await verifyOTP(user.id, loginRequest.otp);

      if (!isOtpCorrect) {
        throw Exception("Invalid OTP. Please try again.");
      }

      return User(id: "id", fullName: "fullname", email: "@gmail.com", phoneNumber: "01129894221");
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception("Login failed: ${e.response?.data["message"] ?? e.message}");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }


  @override
  Future<User> register(RegistrationRequest registerRequest) async {
    final response = await ref.read(remoteClientProvider).post(
      "dummyregistrationapirequest",
      data: registerRequest.toJson(),
    );
    final  user = User.fromJson(response.data);
    return User(id: "123", fullName: "zood", email: "zood@gmail.com", phoneNumber: "01111111111");
  }

  @override
  Future<void> resendOTP() async {
    await ref.read(remoteClientProvider).post("dummyotpapirequest");
  }

  @override
  Future<bool> verifyOTP(String userId, String otp) async {
    final response = await ref.read(remoteClientProvider).post(
      "mock_verify_otp_api",
      data: {
        "user_id": userId,
        "otp": otp,
      },
    );

    final isOTPcorrect =  true;
    return isOTPcorrect;
  }
}
