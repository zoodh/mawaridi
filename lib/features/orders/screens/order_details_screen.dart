import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('d MMMM y', context.locale.languageCode).format(order.date);
    final totalAmount = _calculateTotalAmount();

    return Scaffold(
      appBar: AppBar(
        title: Text('orders.quotation'.tr(), style: const TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).colorScheme.surface,
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
              _sectionHeader('orders.company_section'.tr()),
              const SizedBox(height: 4),
              _infoText('${tr('orders.company_info.address')}: ${order.address}'),
              _infoText('${tr('orders.company_info.phone')}: ${order.corporationPhoneNumber}'),
              _infoText('${tr('orders.company_info.email')}: support@moa.redy.com'),
              _infoText('${tr('orders.company_info.date')}: $date'),
              _infoText(tr('orders.quotation_number')),

              const SizedBox(height: 24),
              _sectionHeader('orders.directed_to'.tr()),
              _infoText('${tr('orders.company_info.name')}: ${order.clientName}'),
              _infoText('${tr('orders.company_info.email')}: ${order.clientEmail}'),

              const SizedBox(height: 24),
              _sectionHeader('orders.validity_period'.tr()),
              Text(
                'orders.validity_text'.tr(),
                style: const TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  _sectionHeader('orders.offer_details_section'.tr()),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {},
                    child: Text('orders.export'.tr(), style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              _buildTable(),
              
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${tr('orders.table.total_price')}: $totalAmount',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateTotalAmount() {
    double total = 0;
    for (var product in order.products) {
      total += (double.tryParse(product.price) ?? 0) * order.quantity;
    }
    return total.toStringAsFixed(2);
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
        ...order.products.map((product) => _buildTableRow(
          product.name,
          product.brand,
          order.quantity.toString(),
          product.price,
          (double.tryParse(product.price) ?? 0 * order.quantity).toStringAsFixed(2),
        ))
      ],
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[100]),
      children: [
        Padding(padding: const EdgeInsets.all(8), child: Text('orders.table.product_name'.tr(), textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text('orders.table.brand_name'.tr(), textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text('orders.table.quantity'.tr(), textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text('orders.table.unit_price'.tr(), textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text('orders.table.total_price'.tr(), textAlign: TextAlign.center)),
      ],
    );
  }

  TableRow _buildTableRow(String name, String brand, String quantity, String unitPrice, String totalPrice) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8), child: Text(name, textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text(brand, textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text(quantity, textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text(unitPrice, textAlign: TextAlign.center)),
        Padding(padding: const EdgeInsets.all(8), child: Text(totalPrice, textAlign: TextAlign.center)),
      ],
    );
  }
}
