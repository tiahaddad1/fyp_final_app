import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/buttonComponent.dart';
import 'package:fyp_application/View/caregiverLogin.dart';
import 'package:fyp_application/View/signUpCaregiver.dart';
import 'package:video_player/video_player.dart';

class caregiverWelcome extends StatefulWidget {
  const caregiverWelcome({super.key});

  @override
  State<caregiverWelcome> createState() => _caregiverWelcomeState();
}

class _caregiverWelcomeState extends State<caregiverWelcome> {
  late VideoPlayerController _controller;

  @override
  initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    _controller = VideoPlayerController.asset('lib/assets/backgroundVid.mov')
      ..initialize().then((_) {
        _controller.play();
        _controller.setVolume(0.0);
        _controller.setLooping(true);
        setState(() {});
      });
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color.fromARGB(255, 66, 135, 123),
            automaticallyImplyLeading: false,
          ),
          body: Stack(children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  )),
            ),
             makeAccount(),
          ])),
    );
  }
}

class makeAccount extends StatelessWidget {
  const makeAccount({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          new Column(children: [
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  "lib/assets/logo.png",
                  width: 60,
                  height: 80,
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          decoration: TextDecoration.none, fontSize: 18),
                      children: [
                        TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0), //position of shadow
                                blurRadius: 6.0, //blur intensity of shadow
                                color: Colors.black.withOpacity(
                                    0.8), //color of shadow with opacity
                              ),
                            ],
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: 'autis',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset:
                                        Offset(2.0, 2.0), //position of shadow
                                    blurRadius: 6.0, //blur intensity of shadow
                                    color: Colors.black.withOpacity(
                                        0.8), //color of shadow with opacity
                                  ),
                                ],
                                color: Color.fromARGB(255, 253, 240, 193),
                                fontFamily: 'Righteous-Regular')),
                        TextSpan(
                            text: 'Care!',
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    offset:
                                        Offset(2.0, 2.0), //position of shadow
                                    blurRadius: 6.0, //blur intensity of shadow
                                    color: Colors.black.withOpacity(
                                        0.8), //color of shadow with opacity
                                  ),
                                ],
                                color: Color.fromARGB(255, 66, 135, 123),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Righteous-Regular')),
                      ]),
                )),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 5),
              child: Text(
                  "An interactive way to planning your child's daily routines!",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0), //position of shadow
                        blurRadius: 6.0, //blur intensity of shadow
                        color: Colors.black
                            .withOpacity(0.8), //color of shadow with opacity
                      ),
                    ],
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  )),
            )
          ]),
          new Column(children: [
            buttonComponent(
              colour: Color.fromARGB(255, 66, 135, 123),
              text: "get started",
              function: ()=>{    
          Navigator.push(context,
            MaterialPageRoute(builder: (context) =>signUpCaregiver()))
              }
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text("Already registered?",
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0), //position of shadow
                        blurRadius: 6.0, //blur intensity of shadow
                        color: Color.fromARGB(255, 149, 149, 149)
                            .withOpacity(0.8), //color of shadow with opacity
                      ),
                    ],
                    color: Color.fromARGB(255, 66, 135, 123),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  )),
              RichText(
                  text: TextSpan(
                text: "Login",
                style: TextStyle(
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0), //position of shadow
                      blurRadius: 6.0, //blur intensity of shadow
                      color: Color.fromARGB(255, 149, 149, 149)
                          .withOpacity(0.8), //color of shadow with opacity
                    ),
                  ],
                  color: Color.fromARGB(255, 66, 135, 123),
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => logInCaregiver())),
              ))
            ]),
          ]),
        ]));
  }
}
