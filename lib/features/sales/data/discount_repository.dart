import 'package:new_alegria/features/sales/data/discount_api.dart';
import 'package:new_alegria/features/sales/models/discount_model.dart';

class DiscountRepository {
  final DiscountApi api;

  DiscountRepository(this.api);

  Future<List<DiscountModel>> getDiscounts() {
    return api.fetchDiscounts();
  }
}
