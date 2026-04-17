// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(discountApi)
final discountApiProvider = DiscountApiProvider._();

final class DiscountApiProvider
    extends $FunctionalProvider<DiscountApi, DiscountApi, DiscountApi>
    with $Provider<DiscountApi> {
  DiscountApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discountApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discountApiHash();

  @$internal
  @override
  $ProviderElement<DiscountApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DiscountApi create(Ref ref) {
    return discountApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscountApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscountApi>(value),
    );
  }
}

String _$discountApiHash() => r'5bff0a29db60fe5b7aa308dede64fb0ff52094ca';

@ProviderFor(discountRepository)
final discountRepositoryProvider = DiscountRepositoryProvider._();

final class DiscountRepositoryProvider
    extends
        $FunctionalProvider<
          DiscountRepository,
          DiscountRepository,
          DiscountRepository
        >
    with $Provider<DiscountRepository> {
  DiscountRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discountRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discountRepositoryHash();

  @$internal
  @override
  $ProviderElement<DiscountRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DiscountRepository create(Ref ref) {
    return discountRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscountRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscountRepository>(value),
    );
  }
}

String _$discountRepositoryHash() =>
    r'c0cc3994dec3a29fa69a29afdfea3124fdb2251f';

@ProviderFor(invoiceApi)
final invoiceApiProvider = InvoiceApiProvider._();

final class InvoiceApiProvider
    extends $FunctionalProvider<InvoiceApi, InvoiceApi, InvoiceApi>
    with $Provider<InvoiceApi> {
  InvoiceApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invoiceApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invoiceApiHash();

  @$internal
  @override
  $ProviderElement<InvoiceApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InvoiceApi create(Ref ref) {
    return invoiceApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InvoiceApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InvoiceApi>(value),
    );
  }
}

String _$invoiceApiHash() => r'2d8a1a906b76c8fc9afbe6d6c744501047e723ce';

@ProviderFor(invoiceRepository)
final invoiceRepositoryProvider = InvoiceRepositoryProvider._();

final class InvoiceRepositoryProvider
    extends
        $FunctionalProvider<
          InvoiceRepository,
          InvoiceRepository,
          InvoiceRepository
        >
    with $Provider<InvoiceRepository> {
  InvoiceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invoiceRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invoiceRepositoryHash();

  @$internal
  @override
  $ProviderElement<InvoiceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InvoiceRepository create(Ref ref) {
    return invoiceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InvoiceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InvoiceRepository>(value),
    );
  }
}

String _$invoiceRepositoryHash() => r'f2c847ca09b779260ea7dd1852a185abc596dfbb';
