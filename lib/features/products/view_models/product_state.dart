import 'package:new_alegria/features/products/models/product_model.dart';

class ProductState {
  final String searchQuery;
  final int selectedCategoryId;
  final List<ProductModel> products;

  const ProductState({
    this.searchQuery = '',
    this.selectedCategoryId = 0,
    this.products = const [],
  });

  ProductState copyWith({
    String? searchQuery,
    int? selectedCategoryId,
    List<ProductModel>? products,
  }) {
    return ProductState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      products: products ?? this.products,
    );
  }
}
