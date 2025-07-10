import 'package:flutter/material.dart';

class CommonQuestionsScreen extends StatelessWidget {
  const CommonQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFFFBEFF5);

    return Scaffold(
      appBar: AppBar(
        title: Text("الاسئلة الشائعة",),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,

        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Center(
              child: Text(
                "How Can we help you?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Divider(),
            SizedBox(height: 24,)   ,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "البحث عن السؤال",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    FaqCard(
                      question: "Does Home Finder provide assistance in mortgage approvals?",
                      shortAnswer: "Not directly",
                      fullAnswer:
                      "While we don't directly handle mortgage approvals, we have partnered with reputable financial institutions that can assist you in securing a mortgage. Feel free to use our app to connect with these partners.",
                    ),
                    SizedBox(height: 20),
                    FaqCard(
                      question: "How do I list my property?",
                      shortAnswer: 'Navigate to the "List Your Property" section. Fill in the details.',
                      fullAnswer: null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FaqCard extends StatelessWidget {
  final String question;
  final String shortAnswer;
  final String? fullAnswer;

  const FaqCard({
    super.key,
    required this.question,
    required this.shortAnswer,
    this.fullAnswer,
  });

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFFFBEFF5);
    const padding = EdgeInsets.all(16);
    const questionStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const answerStyle = TextStyle(fontSize: 14, color: Colors.black87);

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: questionStyle),
          const SizedBox(height: 8),
          Text("The short answer is : $shortAnswer", style: answerStyle),
          if (fullAnswer != null) ...[
            const Divider(height: 24, thickness: 1, color: Colors.black12),
            Text(fullAnswer!, style: answerStyle),
          ],
        ],
      ),
    );
  }
}
