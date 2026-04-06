import 'package:new_alegria/features/products/models/product_model.dart';
import 'package:new_alegria/features/products/view_models/product_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_view_model.g.dart';

@riverpod
class ProductViewModel extends _$ProductViewModel {
  @override
  ProductState build() {
    return ProductState(products: _mockProducts);
  }

  final List<String> categories = ['All', 'Bread', 'Pastries', 'Drinks'];

  final List<ProductModel> _mockProducts = [
    ProductModel(
      id: 1,
      name: 'Pandesal',
      sellingPrice: 5,
      sku: '',
      costPrice: 20,
      categoryId: 1,
      categoryName: 'Bread',
      modifiers: [],
    ),
    ProductModel(
      id: 2,
      name: 'Ensaymada',
      sellingPrice: 20,
      sku: '',
      costPrice: 15,
      categoryId: 1,
      categoryName: 'Bread',
      modifiers: [],
    ),
    ProductModel(
      id: 3,
      name: 'Croissant',
      sellingPrice: 45,
      sku: '',
      costPrice: 30,
      categoryId: 1,
      categoryName: 'Bread',
      modifiers: [],
    ),
    ProductModel(
      id: 4,
      name: 'Coffee',
      sellingPrice: 30,
      sku: '',
      costPrice: 11,
      categoryId: 2,
      categoryName: 'Drinks',
      modifiers: [],
    ),
  ];

  // 📅 formatted date (presentation logic)
  String get formattedDate {
    final now = DateTime.now();
    return "${now.month.toString().padLeft(2, '0')}/"
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.year}";
  }

  List<ProductModel> get filteredProducts {
    return state.products.where((product) {
      final matchesCategory =
          state.selectedCategory == 'All' ||
          product.categoryName == state.selectedCategory;

      final matchesSearch = product.name.toLowerCase().contains(
        state.searchQuery.toLowerCase(),
      );

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void setSearchQuery(String value) {
    state = state.copyWith(searchQuery: value);
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }
}
