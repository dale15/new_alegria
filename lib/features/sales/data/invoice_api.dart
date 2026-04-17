import 'package:new_alegria/core/network/api_endpoints.dart';
import 'package:new_alegria/core/network/dio_client.dart';
import 'package:new_alegria/features/sales/models/invoice_request_model.dart';

class InvoiceApi {
  final DioClient client;

  InvoiceApi(this.client);

  Future<Map<String, dynamic>> createInvoice(
    CreateInvoiceRequest request,
  ) async {
    final response = await client.post(
      ApiEndpoints.createInvoice,
      data: request.toJson(),
    );

    return response.data;
  }
}
