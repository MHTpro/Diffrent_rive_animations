import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:test_project/pages/animation4.dart';

class AnimationThree extends StatefulWidget {
  const AnimationThree({super.key});

  @override
  State<AnimationThree> createState() => _AnimationThreeState();
}

class _AnimationThreeState extends State<AnimationThree> {
  Artboard? _artboard;
  late StateMachineController _stateMachineController;

  //load rive animation (function)
  Future<void> loadAnimation() async {
    final data = await rootBundle.load("assets/anim3.riv");
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;

    setState(
      () {
        _artboard = artboard;
        _stateMachineController = StateMachineController.fromArtboard(
          _artboard!,
          //name of the animation in (Rive editor on website)
          "State Machine 1",
        )!;
        _artboard!.addController(_stateMachineController);
      },
    );
  }

  @override
  void initState() {
    //load animation
    loadAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _artboard != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 500.0,
                    width: 500.0,

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
                          builder: (context) => const AnimationFour(),
                        ),
                      );
                    },
                    child: const Text(
                      "Next Animation",
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
