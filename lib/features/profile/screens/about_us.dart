import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class WhoAreWeScreen extends StatelessWidget {
  const WhoAreWeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const headingStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF5C3B42),
    );
    const subheadingStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFF5C3B42),
    );
    const bodyStyle = TextStyle(
      fontSize: 15,
      color: Colors.black87,
      height: 1.8,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('profile.about_us'.tr()),
        backgroundColor: Color(0xFF5C3B42),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/about-us-1.png", fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text('profile.who_are_we'.tr(), style: subheadingStyle, textAlign: TextAlign.right),
            const SizedBox(height: 8),
            const Text(
              "مواردي هي شركة وطنية متميزة في قطاع البناء والتشييد. تقدم حلولاً متكاملة لتسهيل عملية طلب المواد الإنشائية عبر منصتها. تتيح لعملائها تصفح مجموعة واسعة من المنتجات ومقارنة الخيارات بكل يسر لتجربة شراء سريعة وذكية بضغطة زر.",
              style: bodyStyle,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 24),
            Image.asset("assets/images/about-us-2.png", fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text('profile.our_story'.tr(), style: subheadingStyle, textAlign: TextAlign.right),
            const SizedBox(height: 8),
            const Text(
              "رغم اختلاف الناس في كثير من الأمور، يبقى هناك اتفاق شبه كامل على أن أكثر مرحلة مؤلمة في تجربة البناء هي البحث عن المواد، المقارنة بين الخيارات، التفاوض بين الجودة والسعر، ومن ثم الأمانة والاستغلال. يجعل هذه المرحلة مليئة بالتحديات للمستهلك.\n\nمن هذا التحدي الشخصي الذي مر به مؤسسو مواردي، نشأت هذه المنصة وكل التفاصيل فيها، لتنتقل من المعاناة، إلى إضافة منصة الأدوات الصحيحة. سواءً إن كنت شخص عادي تبحث عن حل، مقاول، أو كنت صاحب منصة وتبحث عن منتج، مواردي في هذا المكان. وتجمع كل ما تريده من مواد بناء، تجهيزات، وأدوات في مكان واحد، مع خدمات متكاملة تشمل التوصيل، التحميل،"
                  " وحتى الاستبدال والاسترجاع.",
              style: bodyStyle,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 32),
            const Center(
              child: Column(
                children: [
                  Text(
                    "المحفز الفعلي لكل خطوة نجاح",
                    style: subheadingStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "تعرّف على فريق عمل",
                    style: headingStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Image.asset("assets/images/about-us-2.png", fit: BoxFit.cover),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
