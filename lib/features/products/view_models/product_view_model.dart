import 'package:new_alegria/core/network/dio_client.dart';
import 'package:new_alegria/features/products/data/product_api.dart';
import 'package:new_alegria/features/products/data/product_repository.dart';
import 'package:new_alegria/features/products/models/product_model.dart';
import 'package:new_alegria/features/products/view_models/product_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_view_model.g.dart';

/// 🔥 Dio
@riverpod
DioClient dioClient(Ref ref) {
  return DioClient();
}

/// 🔥 API
@riverpod
ProductApi productApi(Ref ref) {
  return ProductApi(ref.watch(dioClientProvider));
}

/// 🔥 Repository
@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository(ref.watch(productApiProvider));
}

@riverpod
class ProductViewModel extends _$ProductViewModel {
  @override
  ProductState build() {
    _loadProducts();
    return const ProductState();
  }

  Future<void> _loadProducts() async {
    final products = await ref.read(productRepositoryProvider).getProducts();

    state = state.copyWith(products: products);
  }

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
          state.selectedCategoryId == 0 ||
          product.categoryId == state.selectedCategoryId;

      final matchesSearch = product.name.toLowerCase().contains(
        state.searchQuery.toLowerCase(),
      );

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void setSearchQuery(String value) {
    state = state.copyWith(searchQuery: value);
  }

  void selectCategory(int categoryId) {
    if (state.selectedCategoryId == categoryId) return;
    state = state.copyWith(selectedCategoryId: categoryId);
  }
}
