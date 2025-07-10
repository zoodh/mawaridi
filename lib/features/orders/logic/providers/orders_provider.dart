import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/features/orders/logic/api/orders_api.dart';

import '../../../authentication/apis/authentication_api.dart';
import '../../models/order.dart';

final fetchOrdersProvider =
AsyncNotifierProvider.family<OrdersNotifier, List<Order>, String>(
      () => OrdersNotifier(),
);

class OrdersNotifier extends FamilyAsyncNotifier<List<Order>, String> {
  IOrdersApi get _api => ref.read(ordersApiProvider);

  @override
  Future<List<Order>> build(String userId) async {
    return await _api.fetchOrders(userId);
  }
}
