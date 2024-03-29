import 'package:blogit/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'signup_screen.dart';
import 'constants/constants.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Constants.kPrimaryColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: Constants.statusBarColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.4,
                  child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_ljx86sv6.json')
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: Constants.textIntro,
                          style: TextStyle(
                            color: Constants.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                      TextSpan(
                          text: Constants.textIntroDesc1,
                          style: TextStyle(color: Constants.kGreenColor, fontWeight: FontWeight.bold, fontSize: 30.0)),
                      TextSpan(
                          text: Constants.textIntroDesc2,
                          style: TextStyle(color: Constants.kBlackColor, fontWeight: FontWeight.bold, fontSize: 30.0)),
                    ])),
                SizedBox(height: size.height * 0.01),
                const Text(
                  Constants.textSmallSignUp,
                  style: TextStyle(color: Constants.kDarkGreyColor),
                ),
                SizedBox(height: size.height * 0.1),
                SizedBox(
                  width: size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpView()),
                      );
                    },
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(Constants.kBlackColor),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
                    child: const Text(Constants.textStart),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInView()),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Constants.kGreyColor),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
                    child: const Text(
                      Constants.textSignIn,
                      style: TextStyle(color: Constants.kBlackColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
