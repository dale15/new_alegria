// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryApi)
final categoryApiProvider = CategoryApiProvider._();

final class CategoryApiProvider
    extends $FunctionalProvider<CategoryApi, CategoryApi, CategoryApi>
    with $Provider<CategoryApi> {
  CategoryApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryApiHash();

  @$internal
  @override
  $ProviderElement<CategoryApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CategoryApi create(Ref ref) {
    return categoryApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryApi>(value),
    );
  }
}

String _$categoryApiHash() => r'd694d9eea3a002034eddb8f5ad43681132688032';

@ProviderFor(categoryRepository)
final categoryRepositoryProvider = CategoryRepositoryProvider._();

final class CategoryRepositoryProvider
    extends
        $FunctionalProvider<
          CategoryRepository,
          CategoryRepository,
          CategoryRepository
        >
    with $Provider<CategoryRepository> {
  CategoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<CategoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CategoryRepository create(Ref ref) {
    return categoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryRepository>(value),
    );
  }
}

String _$categoryRepositoryHash() =>
    r'59a23142d668447d4d014a57b7cd4f744190e3db';

/// 🔥 API

@ProviderFor(productApi)
final productApiProvider = ProductApiProvider._();

/// 🔥 API

final class ProductApiProvider
    extends $FunctionalProvider<ProductApi, ProductApi, ProductApi>
    with $Provider<ProductApi> {
  /// 🔥 API
  ProductApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productApiHash();

  @$internal
  @override
  $ProviderElement<ProductApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProductApi create(Ref ref) {
    return productApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductApi>(value),
    );
  }
}

String _$productApiHash() => r'65eea68078e3d0ea22c4db744f12963d3f559e87';

/// 🔥 Repository

@ProviderFor(productRepository)
final productRepositoryProvider = ProductRepositoryProvider._();

/// 🔥 Repository

final class ProductRepositoryProvider
    extends
        $FunctionalProvider<
          ProductRepository,
          ProductRepository,
          ProductRepository
        >
    with $Provider<ProductRepository> {
  /// 🔥 Repository
  ProductRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProductRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductRepository create(Ref ref) {
    return productRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductRepository>(value),
    );
  }
}

String _$productRepositoryHash() => r'f32653ccd01a40c1db3d989fc480ca13afc3d90f';
