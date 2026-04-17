import 'package:new_alegria/core/network/api_endpoints.dart';
import 'package:new_alegria/core/network/dio_client.dart';
import 'package:new_alegria/features/sales/models/discount_model.dart';

class DiscountApi {
  final DioClient client;

  DiscountApi(this.client);

  Future<List<DiscountModel>> fetchDiscounts() async {
    final response = await client.get<List<dynamic>>(ApiEndpoints.discounts);
    final data = response.data;

    return data!.map((json) => DiscountModel.fromJson(json)).toList();
  }
}
