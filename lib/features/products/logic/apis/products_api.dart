
import 'package:dio/dio.dart';
import 'package:mawaridii/app/logic/remote_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:mawaridii/features/products/models/product.dart';


  final productApiProvider = Provider<IProductApi>((ref) => _ProductApi(ref));

  abstract interface class IProductApi {
    Future<List<Product>> fetchProducts();
    Future<List<Product>> fetchProductsByCategory(String category);
  }
  class _ProductApi implements IProductApi {
    final Ref ref;
    final Dio _dio;

    _ProductApi(this.ref) : _dio =ref.read(remoteClientProvider);

    @override
    Future<List<Product>> fetchProducts() async {
       // _dio.get('https://mock.api/products');

      return demoProducts;
    }

    @override
    Future<List<Product>> fetchProductsByCategory(String category) async {
      // _dio.get(
      //  'https://mock.api/products/by-category',
    //    queryParameters: {'category': category},
    //  );

      return demoProducts.where((product) => product.category == category).toList();
    }
  }





  const List<Product> demoProducts = [
    Product(
      id: 'p1',
      name: 'حوض',
      description: 'High-quality wireless headphones with noise cancellation.',
      imagePath: 'assets/images/product-1.png',
      brand: 'SoundMax',
      galleryImages: [
      ],
      price: '149.99',
      category: 'الادوات الصحية',
      rating: 4.5,
      stock: 25,
      reviewCount: 132,
    ),
    Product(
      id: 'p2',
      name: 'صنبور',
      description: 'Ergonomic office chair made of premium leather.',
      imagePath: 'assets/images/product-2.png',
      brand: 'ComfortZone',
      galleryImages: [
      ],
      price: '249.00',
      category: 'الادوات الصحية',
      rating: 4.2,
      stock: 10,
      reviewCount: 58,
    ),
    Product(
      id: 'p3',
      name: 'خلاط',
      description: 'Keeps drinks cold for 24 hours and hot for 12.',
      imagePath: 'assets/images/product-3.png',

      brand: 'HydroPro',
      galleryImages: [
      ],
      price: '29.99',
      category: 'عوازل',
      rating: 4.8,
      stock: 150,
      reviewCount: 327,
    ),
    Product(
      id: 'p4',
      name: 'خلاط ',
      description: 'Precision optical sensor with RGB lighting and 7 buttons.',
      imagePath: 'assets/images/product-4.png',
      brand: 'عوازل',
      galleryImages: [
      ],
      price: '59.99',
      category: 'عوازل',
      rating: 4.6,
      stock: 50,
      reviewCount: 210,
    ),
  ];
