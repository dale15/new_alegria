import 'package:new_alegria/features/products/models/category_model.dart';
import 'package:new_alegria/features/products/providers/product_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_view_model.g.dart';

@riverpod
class CategoryViewModel extends _$CategoryViewModel {
  @override
  Future<List<CategoryModel>> build() async {
    return ref.watch(categoryRepositoryProvider).getCategories();
  }
}
