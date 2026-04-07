import 'package:new_alegria/core/network/api_endpoints.dart';
import 'package:new_alegria/core/network/dio_client.dart';
import 'package:new_alegria/features/products/models/product_model.dart';

class ProductApi {
  final DioClient client;

  ProductApi(this.client);

  Future<List<ProductModel>> fetchProducts() async {
    final response = await client.get<List<dynamic>>(ApiEndpoints.products);

    final data = response.data;

    if (data == null) {
      throw Exception('No data received');
    }

    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}
