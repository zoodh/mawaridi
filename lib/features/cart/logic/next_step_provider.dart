import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final nextStepProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});