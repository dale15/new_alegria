import 'package:new_alegria/core/network/dio_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_providers.g.dart';

@riverpod
DioClient dioClient(Ref ref) {
  return DioClient();
}
