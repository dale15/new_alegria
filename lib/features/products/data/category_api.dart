import 'package:new_alegria/core/network/api_endpoints.dart';
import 'package:new_alegria/core/network/dio_client.dart';
import 'package:new_alegria/features/products/models/category_model.dart';

class CategoryApi {
  final DioClient client;

  CategoryApi(this.client);

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await client.get<List<dynamic>>(ApiEndpoints.categories);

    final data = response.data;

    return data!.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
