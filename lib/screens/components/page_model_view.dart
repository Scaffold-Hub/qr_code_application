import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:qr_project/screens/components/image_path.dart';
import 'package:qr_project/theme/light_theme.dart';

PageViewModel buildPageViewModel({
  required BuildContext context,
  required String title,
  required String body,
  required String path,
}) {
  return PageViewModel(
    title: title,
    body: body,
    decoration: PageDecoration(
      titleTextStyle: LightTheme().theme.textTheme.headline1!,
      bodyTextStyle: LightTheme().theme.textTheme.bodyText1!,
    ),
    image: buildImageAsset(context, path),
  );
}

PageViewModel firstSpecialPageViewModel({
  required BuildContext context,
  required String title,
}) {
  return PageViewModel(
    title: title,
    decoration: PageDecoration(
      titlePadding: const EdgeInsets.only(top: 100.0),
      titleTextStyle: TextStyle(
        color: LightTheme().theme.backgroundColor,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),
    bodyWidget: Divider(
      color: LightTheme().theme.backgroundColor,
      thickness: 2,
    ),
  );
}
