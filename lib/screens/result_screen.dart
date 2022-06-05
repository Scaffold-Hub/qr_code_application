import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  late Barcode result;
  ResultPage(this.result, {Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Barcode result;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late bool isLink;

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffFE1919), Color(0xffEC5050)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    result = widget.result;
    isLink = linkHandler('$result.code');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("FlutterQR - Result"),
      ),
      body: Column(
        children: [
          _buildResultView(),
          _buildSheet(),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                width: 100,
                height: 100,
                child: Lottie.asset("assets/lottie/qr_anim.json"),
              ),
              const SizedBox(height: 20),
              Text(
                "Successful",
                style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    foreground: Paint()..shader = linearGradient),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(6)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 12,
                      ),
                      child: Text(
                        "${result.code}",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheet() {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: "${result.code}"));
                    _scaffoldKey.currentState!.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Copied *-*',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.bookmark_add_sharp,
                      color: Colors.grey.shade200,
                      size: 40,
                    ),
                  ),
                ),
                isLink
                    ? GestureDetector(
                        onTap: () {
                          _launchURL("${result.code}");
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.web,
                            color: Colors.grey.shade200,
                            size: 40,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _launchURL("${result.code}");
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.web_asset,
                            color: Colors.grey.shade200,
                            size: 40,
                          ),
                        ),
                      )
              ],
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    "Try Again",
                    style: GoogleFonts.montserrat(
                        fontSize: 30, color: Colors.grey.shade200),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool linkHandler(String data) {
    Pattern urlPattern =
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
    RegExp regExp = RegExp('$urlPattern');
    return regExp.hasMatch(data);
  }

  // ignore: deprecated_member_use
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
