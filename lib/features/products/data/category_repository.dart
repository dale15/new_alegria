import 'package:new_alegria/features/products/data/category_api.dart';
import 'package:new_alegria/features/products/models/category_model.dart';

class CategoryRepository {
  final CategoryApi api;

  CategoryRepository(this.api);

  Future<List<CategoryModel>> getCategories() {
    return api.fetchCategories();
  }
}
