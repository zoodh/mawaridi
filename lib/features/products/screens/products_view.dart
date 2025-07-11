
import 'package:flutter/material.dart';
import 'package:mawaridii/app/widgets/category_grid.dart';
import 'package:mawaridii/features/products/widgets/product_grid.dart';
import 'package:mawaridii/app/widgets/search_bar.dart';
import 'package:mawaridii/features/orders/widgets/upload_card.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

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
              CategoryGrid(isCircular:  true,),
              CustomSearchBar(),
              ProductGrid(),
            ],
          ),
        )
    );
  }
}


