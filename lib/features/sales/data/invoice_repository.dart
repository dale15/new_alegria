import 'package:new_alegria/features/sales/data/invoice_api.dart';
import 'package:new_alegria/features/sales/models/invoice_request_model.dart';

class InvoiceRepository {
  final InvoiceApi api;

  InvoiceRepository(this.api);

  Future<Map<String, dynamic>> createInvoice(CreateInvoiceRequest request) {
    return api.createInvoice(request);
  }
}
