import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:qr_project/constant.dart';
import 'package:qr_project/screens/qr_code_screen.dart';
import 'package:qr_project/theme/light_theme.dart';
import 'components/intro_read_text.dart';
import 'components/page_model_view.dart';

class IntroductionsScreen extends StatelessWidget {
  const IntroductionsScreen({Key? key}) : super(key: key);

  final _kpath =
      'https://images.unsplash.com/photo-1604782206219-3b9576575203?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fG1pbmltYWx8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60';

  @override
  Widget build(BuildContext context) {
    final Constant constant = Constant();
    return Stack(
      children: [
        Image.network(
          _kpath,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: IntroductionScreen(
            pages: [
              firstSpecialPageViewModel(
                title: constant.kWelcomeTitle,
                context: context,
              ),
              buildPageViewModel(
                context: context,
                title: constant.kPageModelTitle1,
                body: constant.kPageModelBody1,
                path: 'assets/family.png',
              ),
              buildPageViewModel(
                context: context,
                title: constant.kPageModelTitle2,
                body: constant.kPageModelBody2,
                path: 'assets/star.png',
              ),
              buildPageViewModel(
                context: context,
                title: constant.kPageModelTitle3,
                body: constant.kPageModelBody3,
                path: 'assets/avengers.png',
              ),
            ],
            done: buildIntroText(context),
            onDone: () => goToHome(context),
            showSkipButton: true,
            skip: Text(
              Constant().kOnBoardTitle,
              style: TextStyle(
                  color: LightTheme().theme.backgroundColor, fontSize: 16.0),
            ),
            onSkip: () => goToHome(context),
            next: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 21.0,
              color: LightTheme().theme.backgroundColor,
            ),
            globalBackgroundColor: Colors.transparent,
            dotsDecorator: getDotDecoration(),
            nextFlex: 0,
            dotsFlex: 3,
          ),
        ),
      ],
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: const Color.fromARGB(255, 122, 121, 121),
        activeColor: const Color.fromARGB(255, 200, 191, 191),
        size: const Size(15, 10),
        activeSize: const Size(25, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const QrCodeScreen()),
      );
}
