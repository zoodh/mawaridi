import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/features/authentication/models/login_request.dart';
import 'package:mawaridii/features/authentication/models/registriation_request.dart';

import '../apis/authentication_api.dart';

final authProvider =
NotifierProvider<AuthNotifier, void>(AuthNotifier.new);

class AuthNotifier extends Notifier<void> {
  //* Dependencies
  IAuthApi get _api => ref.read(authApiProvider);

  @override
   build() {

  }

  Future<void> register(RegistrationRequest registrationRequest)async {

    await  _api.register(registrationRequest);

  }

  Future<void> login(LoginRequest loginRequest)async {
   await _api.login(loginRequest);

  }

}