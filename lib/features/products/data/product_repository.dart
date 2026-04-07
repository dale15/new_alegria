import 'package:new_alegria/features/products/data/product_api.dart';
import 'package:new_alegria/features/products/models/product_model.dart';

class ProductRepository {
  final ProductApi api;

  ProductRepository(this.api);

  Future<List<ProductModel>> getProducts() async {
    return api.fetchProducts();
  }
}
