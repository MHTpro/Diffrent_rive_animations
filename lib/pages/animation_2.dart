import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:test_project/pages/animation3.dart';

class AnimationTwo extends StatefulWidget {
  const AnimationTwo({Key? key}) : super(key: key);

  @override
  State<AnimationTwo> createState() => _AnimationTwoState();
}

class _AnimationTwoState extends State<AnimationTwo> {
  Artboard? _artboard;
  late RiveAnimationController _animationController;

  //load rive animation (function)
  Future<void> loadAnimation() async {
    final data = await rootBundle.load("assets/anim2.riv");
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;

    setState(
      () {
        _artboard = artboard;

        //use SimpleAmimation for my controller for rive animation
        _animationController = SimpleAnimation(
          //actual name of animation.
          'Demo',
        );
        _artboard!.addController(_animationController);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //load animation
    loadAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _artboard != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 300.0,
                    width: 300.0,

                    //Rive widget to show animation
                    child: Rive(
                      artboard: _artboard!,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AnimationThree(),
                        ),
                      );
                    },
                    child: const Text(
                      "Next Animation",
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
