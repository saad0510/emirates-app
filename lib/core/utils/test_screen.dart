import 'package:flutter/material.dart';

import '../extensions/context_ext.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.height,
          width: context.width,
          child: Column(
            children: [
              Text(
                "Headline 1",
                textAlign: TextAlign.center,
                style: context.textTheme.headline1,
              ),
              Text(
                "Headline 2",
                textAlign: TextAlign.center,
                style: context.textTheme.headline2,
              ),
              Text(
                "Headline 3",
                textAlign: TextAlign.center,
                style: context.textTheme.headline3,
              ),
              Text(
                "Headline 4",
                textAlign: TextAlign.center,
                style: context.textTheme.headline4,
              ),
              Text(
                "Headline 5",
                textAlign: TextAlign.center,
                style: context.textTheme.headline5,
              ),
              Text(
                "Headline 6",
                textAlign: TextAlign.center,
                style: context.textTheme.headline6,
              ),
              Text(
                "Body 1",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyText1,
              ),
              Text(
                "Body 2",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyText2,
              ),
              Text(
                "Subtitle 1",
                textAlign: TextAlign.center,
                style: context.textTheme.subtitle1,
              ),
              Text(
                "Subtitle 2",
                textAlign: TextAlign.center,
                style: context.textTheme.subtitle2,
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
