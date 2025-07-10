import 'package:flutter/material.dart';
import 'package:mawaridii/features/products/widgets/upload_card.dart';
import 'package:easy_localization/easy_localization.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  String? selectedRegion;
  String? selectedCity;
  String? selectedDistrict;

  bool selectAll = false;
  Set<int> selectedShops = {0};

  final List<String> locations = [
    "شركة الفريد (مدينة الرياض)",
    "شركة الفريد (مدينة الرياض)",
    "شركة الفريد (مدينة الرياض)"
  ];

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(8));

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          UploadCard(),
          const SizedBox(height: 24),
          Text('orders.location.select_location'.tr()),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "أدخل المنطقة",
              border: border,
            ),
            value: selectedRegion,
            items: ["المنطقة الأولى", "المنطقة الثانية"]
                .map((region) => DropdownMenuItem(value: region, child: Text(region)))
                .toList(),
            onChanged: (val) => setState(() => selectedRegion = val),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "أدخل المدينة",
              border: border,
            ),
            value: selectedCity,
            items: ["الرياض", "جدة"]
                .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                .toList(),
            onChanged: (val) => setState(() => selectedCity = val),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "أدخل الحي",
              border: border,
            ),
            value: selectedDistrict,
            items: ["الحي الأول", "الحي الثاني"]
                .map((district) => DropdownMenuItem(value: district, child: Text(district)))
                .toList(),
            onChanged: (val) => setState(() => selectedDistrict = val),
          ),
          const SizedBox(height: 24),
          Text('orders.location.select_company'.tr()),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "بحث عن الشركة أو محل",
              border: border,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: selectAll,
                onChanged: (value) {
                  setState(() {
                    selectAll = value!;
                    if (selectAll) {
                      selectedShops = {for (int i = 0; i < locations.length; i++) i};
                    } else {
                      selectedShops.clear();
                    }
                  });
                },
              ),
              Text('orders.location.select_all'.tr()),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(locations.length, (index) {
            return Card(
              child: CheckboxListTile(
                title: Text(locations[index]),
                secondary: const Icon(Icons.storefront),
                value: selectedShops.contains(index),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedShops.add(index);
                    } else {
                      selectedShops.remove(index);
                    }
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
