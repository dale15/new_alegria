import 'package:new_alegria/core/providers/core_providers.dart';
import 'package:new_alegria/features/sales/data/discount_api.dart';
import 'package:new_alegria/features/sales/data/discount_repository.dart';
import 'package:new_alegria/features/sales/data/invoice_api.dart';
import 'package:new_alegria/features/sales/data/invoice_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
DiscountApi discountApi(Ref ref) {
  return DiscountApi(ref.watch(dioClientProvider));
}

@riverpod
DiscountRepository discountRepository(Ref ref) {
  return DiscountRepository(ref.watch(discountApiProvider));
}

@riverpod
InvoiceApi invoiceApi(Ref ref) {
  final client = ref.watch(dioClientProvider);
  return InvoiceApi(client);
}

@riverpod
InvoiceRepository invoiceRepository(Ref ref) {
  final api = ref.watch(invoiceApiProvider);
  return InvoiceRepository(api);
}
