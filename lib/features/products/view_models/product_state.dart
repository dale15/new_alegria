import 'package:new_alegria/features/products/models/product_model.dart';

class ProductState {
  final String searchQuery;
  final String selectedCategory;
  final List<ProductModel> products;

  const ProductState({
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.products = const [],
  });

  ProductState copyWith({
    String? searchQuery,
    String? selectedCategory,
    List<ProductModel>? products,
  }) {
    return ProductState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      products: products ?? this.products,
    );
  }
}
