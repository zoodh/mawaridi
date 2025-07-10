
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/features/products/logic/providers/products_provider.dart';

import '../../features/products/models/category.dart';
class CategoryGrid extends ConsumerWidget {
  final List<Category> categories;
  final bool isCircular;

  const CategoryGrid({
    super.key,
    this.categories = sampleCategories,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCategory = const Category(name: 'الكل', imagePath: 'assets/images/all-category.png');
    final displayCategories = [allCategory, ...categories];

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: SizedBox(
        height: isCircular ? 70 : 90,
        child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          mainAxisSpacing: 0,
          children: List.generate(displayCategories.length, (index) {
            final category = displayCategories[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
    if (category == allCategory) {
      ref.read(fetchProductsProvider.notifier).fetchProducts();
    }else{
      ref.read(fetchProductsProvider.notifier).fetchProductsByCategory(
          category.name);
    }

    },
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                      borderRadius: isCircular ? null : BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipRRect(
                      borderRadius: isCircular
                          ? BorderRadius.circular(100)
                          : BorderRadius.circular(10),
                      child: Image.asset(
                        category.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category.name,
                  style: const TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}


const List<Category> sampleCategories = [
  Category(name: 'الادوات الصحية', imagePath: 'assets/images/category-8.png'),
  Category(name: 'مواد البناء', imagePath: 'assets/images/category-4.png'),
  Category(name: 'الادوات الكهربية', imagePath: 'assets/images/category-3.png'),
  Category(name: 'دهانات', imagePath: 'assets/images/category-5.png'),
  Category(name: 'عوازل', imagePath: 'assets/images/category-6.png'),
];