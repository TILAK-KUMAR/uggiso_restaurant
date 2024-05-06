import 'package:flutter/material.dart';

class SuccessfulOnboardingMessage extends StatefulWidget {
  const SuccessfulOnboardingMessage({super.key});

  @override
  State<SuccessfulOnboardingMessage> createState() => _SuccessfulOnboardingMessageState();
}

class _SuccessfulOnboardingMessageState extends State<SuccessfulOnboardingMessage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text('Thank you message'),
      ),
    ));
  }
}
