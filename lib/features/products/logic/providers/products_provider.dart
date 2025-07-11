import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/features/products/models/product.dart';
import '../apis/products_api.dart';

final fetchProductsProvider =
AsyncNotifierProvider<ProductsNotifier, List<Product>>(
      () => ProductsNotifier(),
);

class ProductsNotifier extends AsyncNotifier<List<Product>> {
  IProductApi get _api => ref.read(productApiProvider);

  @override
  Future<List<Product>> build() async {
    return await _api.fetchProducts();
  }

  Future<void> fetchProducts() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 200));
      final products = await _api.fetchProducts();
      state = AsyncData(products);

  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 200));
      final products = await _api.fetchProductsByCategory(categoryId);
      state = AsyncData(products);

  }
}

