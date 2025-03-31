import 'package:flutter/material.dart';
import 'package:shoprite/components/button.dart';
import 'package:shoprite/components/logo_text.dart';
import '../components/default_scaffold.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const LogoText(
              size: 42,
            ),
            Column(
              children: [
                Text("Welcome to ShopRite", style: textTheme.headlineLarge),
                Text("Enter your phone number to get started", style: textTheme.bodyLarge),
              ],
            ),
            Button(text: "hi", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
