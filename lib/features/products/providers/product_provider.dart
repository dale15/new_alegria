import 'package:new_alegria/core/providers/core_providers.dart';
import 'package:new_alegria/features/products/data/category_api.dart';
import 'package:new_alegria/features/products/data/category_repository.dart';
import 'package:new_alegria/features/products/data/product_api.dart';
import 'package:new_alegria/features/products/data/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
CategoryApi categoryApi(Ref ref) {
  return CategoryApi(ref.watch(dioClientProvider));
}

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  return CategoryRepository(ref.watch(categoryApiProvider));
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
