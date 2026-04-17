// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
