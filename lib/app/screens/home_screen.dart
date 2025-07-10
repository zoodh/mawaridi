import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../features/cart/screens/cart_screen.dart';
import '../../features/orders/screens/orders_view.dart';
import '../../features/products/screens/products_view.dart';
import '../../features/profile/screens/profile_view.dart';
import '../logic/bottom_navigation_provider.dart';
import '../widgets/carousel_slide.dart';
import '../widgets/category_grid.dart';
import '../widgets/custom_bottom_navigation.dart';
import '../widgets/image_card.dart';
import '../../features/products/widgets/product_grid.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    final views = const [
      HomeView(),
      ProductsView(),
      OrdersView(),
      CartView(),
      ProfileView(),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(currentIndex),
          child: views[currentIndex],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(child: CustomSearchBar()),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideCarousel(),
            Text(
              'home.shop_by_category'.tr(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            CategoryGrid(),
            ImageCard(
              title: 'home.expansion_opportunity'.tr(),
              subtitle: 'home.supplier_prompt'.tr(),
              imagePath: 'assets/images/image-card.png',
              onPressed: () {},
            ),
            Text(
              'home.plumbing_tools'.tr(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'home.plumbing_subtitle'.tr(),
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            ProductGrid(),
          ],
        ),
      ),
    );
  }
}
