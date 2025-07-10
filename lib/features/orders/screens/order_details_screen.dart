import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('d MMMM y', 'ar').format(order.date);

    return Scaffold(
      appBar: AppBar(
        title: Text('orders.quotation'.tr(), style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader('🏢 شركة ${order.corporationName}'),
              const SizedBox(height: 4),
              _infoText('${tr('orders.company_info.address')}: ${order.address}'),
              _infoText('${tr('orders.company_info.phone')}: ${order.corporationPhoneNumber}'),
              _infoText('${tr('orders.company_info.email')}: support@moa.redy.com'),
              _infoText('${tr('orders.company_info.date')}: $date'),
              _infoText('${tr('orders.quotation_number')}'),

              const SizedBox(height: 24),
              _sectionHeader('📧 موجه إلى:'),
              _infoText('${tr('orders.company_info.name')}: ${order.clientName}'),
              _infoText('${tr('orders.company_info.email')}: ${order.clientEmail}'),

              const SizedBox(height: 24),
              _sectionHeader('⏰ مدة صلاحية العرض:'),
              const Text(
                'هذا العرض ساري لمدة 7 أيام من تاريخ الإرسال.',
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  _sectionHeader('💼 تفاصيل عرض السعر:'),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 24 , vertical: 6), // Equal padding = square feel
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // or 0 for hard square
                      ),
                    ),
                    onPressed: () {},
                    child: Text('orders.export'.tr(), style: TextStyle(fontSize: 16)),
                  ),

                ],
              ),

              const SizedBox(height: 12),

              const SizedBox(height: 12),
              _buildTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  Widget _infoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buildTable() {
    return Table(
      border: TableBorder.symmetric(
        inside: BorderSide(color: Colors.grey[300]!),
        outside: BorderSide.none,
      ),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
        3: FlexColumnWidth(1.5),
        4: FlexColumnWidth(2),
      },
      children: [
        _buildTableHeader(),
        _buildTableRow('قلب صنبور', 'شركة جدة', '50', '20 ريال', '1000 ريال'),
        _buildTableRow('قلب صنبور', 'شركة جدة', '50', '20 ريال', '1000 ريال'),
      ],
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[100]),
      children: [
        Padding(padding: EdgeInsets.all(8), child: Text('orders.table.product_name'.tr(), textAlign: TextAlign.center)),
        Padding(padding: EdgeInsets.all(8), child: Text('orders.table.brand_name'.tr(), textAlign: TextAlign.center)),
        Padding(padding: EdgeInsets.all(8), child: Text('orders.table.quantity'.tr(), textAlign: TextAlign.center)),
        Padding(padding: EdgeInsets.all(8), child: Text('orders.table.unit_price'.tr(), textAlign: TextAlign.center)),
        Padding(padding: EdgeInsets.all(8), child: Text('orders.table.total_price'.tr(), textAlign: TextAlign.center)),
      ],
    );
  }

  TableRow _buildTableRow(String name, String brand, String quantity, String unitPrice, String totalPrice) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8), child: Text(order.product.name, textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text(order.product.brand, textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text("${order.quantity}", textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text(order.product.price, textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text(order.product.price * order.quantity, textAlign: TextAlign.center)),
      ],
    );
  }
}
