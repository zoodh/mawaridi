import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mawaridii/app/screens/splash_screen.dart';
import 'package:mawaridii/features/cart/screens/checkout_screen.dart';
import 'package:mawaridii/features/orders/models/order.dart';
import 'package:mawaridii/features/orders/screens/upload_file_screen.dart';
import 'package:mawaridii/features/profile/screens/contact_us_screen.dart';
import 'package:mawaridii/features/profile/screens/who_are_we_screen.dart';

import '../app/screens/base_screen.dart';
import '../app/screens/home_screen.dart';
import '../features/authentication/screens/login_screen.dart';
import '../features/authentication/screens/registration_screen.dart';
import '../features/authentication/screens/welcome_screen.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/orders/screens/order_details_screen.dart';
import '../features/products/models/product.dart';
import '../features/products/screens/product_details_screen.dart';
import '../features/profile/screens/common_questions_screen.dart';
import 'custom_transition_page.dart';

enum AppRoute {
  splash,
  base,
  login,
  register,
  welcome,
  home,
  productDetails,
  orderDetails,
  cart,
  checkout,
  commonQuestions,
  whoAreWe,
  contactUs,
  uploadFile,
}

extension AppRouteExtension on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.welcome:
        return '/welcome';
      case AppRoute.base:
        return '/base';
        //subrouts of base
      case AppRoute.register:
        return 'register';
      case AppRoute.login:
        return 'login';

      case AppRoute.cart:
        return '/cart';
      case AppRoute.checkout:
        return '/checkout';

      case AppRoute.home:
        return '/home';
        //subroutes of home
      case AppRoute.productDetails:
        return 'product';
      case AppRoute.orderDetails:
        return 'order';
      case AppRoute.commonQuestions:
        return'commonquestions';
      case AppRoute.whoAreWe:
        return'whoarewe';
      case AppRoute.uploadFile:
        return 'uploadfile';
      case AppRoute.contactUs:
        return 'contactus';
    }
  }

  String get name => toString().split('.').last;
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoute.splash.path,
  routes: [
    GoRoute(
      path: AppRoute.splash.path,
      name: AppRoute.splash.name,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: AppRoute.base.path,
      name: AppRoute.base.name,
      pageBuilder: (context, state) => FadeTransitionPage(
        key: ValueKey('${AppRoute.base.name}_${state.matchedLocation}'),
        child: BaseScreen(),
      ),
    ),
    GoRoute(
      path: AppRoute.welcome.path,
      name: AppRoute.welcome.name,
      pageBuilder: (context, state) => FadeTransitionPage(
        key: ValueKey('${AppRoute.welcome.name}_${state.matchedLocation}'),
        child: WelcomeScreen(),
      ),
      routes: [
        GoRoute(
          path: AppRoute.register.path,
          name: AppRoute.register.name,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: ValueKey('${AppRoute.register.name}_${state.matchedLocation}'),
            child: RegistrationScreen(),
          ),
        ),
        GoRoute(
          path: AppRoute.login.path,
          name: AppRoute.login.name,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: ValueKey('${AppRoute.login.name}_${state.matchedLocation}'),
            child: LoginScreen(),
          ),
        ),
      ],
    ),

    GoRoute(
      path: AppRoute.home.path,
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: AppRoute.productDetails.path,
          name: AppRoute.productDetails.name,
          pageBuilder: (context, state) {
            final product = state.extra as Product;
            return FadeTransitionPage(
              key: ValueKey('${AppRoute.productDetails.name}_${state.matchedLocation}_${product.id}'),
              child: ProductDetailsScreen(product: product),
            );
          },
        ),

        GoRoute(
          path: AppRoute.orderDetails.path,
          name: AppRoute.orderDetails.name,
          builder: (context, state) {
            final order = state.extra as Order;
            return OrderDetailsScreen(order : order);
          },
        ),

        GoRoute(
          path: AppRoute.checkout.path,
          name: AppRoute.checkout.name,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: ValueKey('${AppRoute.checkout.name}_${state.matchedLocation}'),
            child: CheckOutScreen(),
          ),
        ),
        GoRoute(
          path: AppRoute.commonQuestions.path,
          name: AppRoute.commonQuestions.name,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: ValueKey('${AppRoute.commonQuestions.name}_${state.matchedLocation}'),
            child: CommonQuestionsScreen(),
          ),
        ),
        GoRoute(
          path: AppRoute.whoAreWe.path,
          name: AppRoute.whoAreWe.name,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: ValueKey('${AppRoute.whoAreWe.name}_${state.matchedLocation}'),
            child: WhoAreWeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoute.contactUs.path,
          name: AppRoute.contactUs.name,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: ValueKey('${AppRoute.contactUs.name}_${state.matchedLocation}'),
            child: ContactUsScreen(),
          ),
        ),
        GoRoute(
          path: AppRoute.uploadFile.path,
          name: AppRoute.uploadFile.name,
          pageBuilder: (context, state) => FadeTransitionPage(
            key: ValueKey('${AppRoute.uploadFile.name}_${state.matchedLocation}'),
            child: UploadFileScreen(),
          ),
        ),
      ]
    ),
  ],
);



