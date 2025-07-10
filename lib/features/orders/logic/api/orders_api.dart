import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/features/orders/models/order.dart';
import 'package:mawaridii/app/logic/remote_client_provider.dart';

import '../../../products/logic/apis/products_api.dart';

final ordersApiProvider = Provider<IOrdersApi>((ref) => _OrdersApi(ref));

abstract interface class IOrdersApi {
  Future<List<Order>> fetchOrders(String userId);
  Future<void> declineOrder(Order order);
  Future<void> sendOrder(Order order);
  Future<void> approveOrder(Order order);

}


class _OrdersApi implements IOrdersApi {
  final Ref ref;
  final Dio _dio;
  _OrdersApi(this.ref)
      : _dio = ref.read(remoteClientProvider);

  @override
  @override
  Future<List<Order>> fetchOrders(String userId) async {
    final response =  _dio.get(
      'https://mock.api/orders',
      queryParameters: {'userId': userId},
    );


    return List.generate(
      5,
          (index) => Order(
        corporationName: "شركة الحمد ${index + 1}",
        date: DateTime.now(),
        corporationPhoneNumber: "01000000${index + 1}",
        address: "شارع ${index + 1}، القاهرة",
        clientName: "عميل ${index + 1}",
        clientEmail: "client${index + 1}@example.com",
        product: demoProducts.first,
        quantity: 1,
      ),
    );
  }

  @override
  Future<void> approveOrder(Order order) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> declineOrder(Order order) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> sendOrder(Order order) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}




