import 'package:new_alegria/core/network/dio_client.dart';
import 'package:new_alegria/features/products/data/category_api.dart';
import 'package:new_alegria/features/products/data/category_repository.dart';
import 'package:new_alegria/features/products/models/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_view_model.g.dart';

@riverpod
DioClient dioClient(Ref ref) {
  return DioClient();
}

@riverpod
CategoryApi categoryApi(Ref ref) {
  return CategoryApi(ref.watch(dioClientProvider));
}

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  return CategoryRepository(ref.watch(categoryApiProvider));
}

@riverpod
class CategoryViewModel extends _$CategoryViewModel {
  @override
  Future<List<CategoryModel>> build() async {
    return ref.watch(categoryRepositoryProvider).getCategories();
  }
}
