
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/features/products/widgets/product_grid.dart';
import 'package:mawaridii/app/widgets/stylized_filled_button.dart';
import 'package:mawaridii/features/orders/logic/providers/orders_provider.dart';
import 'package:mawaridii/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../products/widgets/upload_card.dart';
import '../logic/providers/tab_provider.dart';
import '../models/order.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              UploadCard(),
              SizedBox(height: 20,),
              OrdersTab()
            ],
          ),
        )
    );
  }
}


class OrdersTab extends ConsumerWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(TabProvider);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StylizedButton(
                text: "الطلبات الحالية",
                function: () => ref.read(TabProvider.notifier).state = 0,
                buttonColor: selectedTab == 0
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                textColor: selectedTab == 0
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                outlineColor: selectedTab == 0
                    ? Colors.transparent
                    : Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: StylizedButton(
                text: "الطلبات السابقة",
                function: () => ref.read(TabProvider.notifier).state = 1,
                buttonColor: selectedTab == 1
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                textColor: selectedTab == 1
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                outlineColor: selectedTab == 1
                    ? Colors.transparent
                    : Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text('orders.company_quotes'.tr(), style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
                ,color: Colors.black
            ),),
          ],
        ),
        if (selectedTab == 0)
          const OrdersListView()
        else
          const OrdersListView(),
      ],
    );
  }
}
class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final state = ref.watch(fetchOrdersProvider("11"));
        return state.when(
          data: (orders) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: OrderTile(order: orders[index]),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text('errors.generic'.tr(args: [e.toString()]))),
        );
      },
    );

  }
}
class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${tr('orders.company_info.name')} ${order.corporationName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${tr('orders.company_info.date')}: ${order.date.toLocal().toString().split(' ')[0]}'),
                Text('${tr('orders.company_info.phone')}: ${order.corporationPhoneNumber}'),
                Text('${tr('orders.company_info.address')}: ${order.address}'),
              ],
            ),
          ),
          Column(
            children: [
              _customButton("تفاصيل العرض", Colors.grey.shade300, Colors.black, (){
                context.goNamed(
                  AppRoute.orderDetails.name,
                  extra: order,
                );

              }),
              const SizedBox(height: 8),
              _customButton("قبول العرض", Colors.green.shade100, Colors.green.shade800,(){}),
              const SizedBox(height: 8),
              _customButton("رفض العرض", Colors.red.shade100, Colors.red.shade800, (){}),
            ],
          ),
        ],
      ),
    );
  }
}
Widget _customButton(
    String text,
    Color bgColor,
    Color textColor,
    VoidCallback onPressed,
    ) {
  return SizedBox(
    width: 100,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 6),
        minimumSize: const Size(0, 35),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      ),
    ),
  );
}
