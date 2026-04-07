// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dioClient)
final dioClientProvider = DioClientProvider._();

final class DioClientProvider
    extends $FunctionalProvider<DioClient, DioClient, DioClient>
    with $Provider<DioClient> {
  DioClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioClientHash();

  @$internal
  @override
  $ProviderElement<DioClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DioClient create(Ref ref) {
    return dioClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DioClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DioClient>(value),
    );
  }
}

String _$dioClientHash() => r'e6a9dcce6804aa95cb3ea31bbb6d28ca56890385';

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

@ProviderFor(CategoryViewModel)
final categoryViewModelProvider = CategoryViewModelProvider._();

final class CategoryViewModelProvider
    extends $AsyncNotifierProvider<CategoryViewModel, List<CategoryModel>> {
  CategoryViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryViewModelHash();

  @$internal
  @override
  CategoryViewModel create() => CategoryViewModel();
}

String _$categoryViewModelHash() => r'76e97dfea017fc8d01a5a1e530a53a1fd8742a4b';

abstract class _$CategoryViewModel extends $AsyncNotifier<List<CategoryModel>> {
  FutureOr<List<CategoryModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CategoryModel>>, List<CategoryModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CategoryModel>>, List<CategoryModel>>,
              AsyncValue<List<CategoryModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
