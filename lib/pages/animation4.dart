import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimationFour extends StatefulWidget {
  const AnimationFour({super.key});

  @override
  State<AnimationFour> createState() => _AnimationFourState();
}

class _AnimationFourState extends State<AnimationFour> {
  Artboard? _artboard;
  late StateMachineController _stateMachineController;

  //create varriable for the inputs of StateMachine
  SMIInput<bool>? hit;
  SMIInput<double>? skins;

  //we have three diffrent skins in this animation
  double numberOfSkins = 0;

  //load animation (function)
  Future<void> loadAnimation() async {
    final data = await rootBundle.load("assets/anim4.riv");
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;

    setState(
      () {
        _artboard = artboard;
        _stateMachineController = StateMachineController.fromArtboard(
          _artboard!,

          //name of the animation in editor
          "State Machine 1",
        )!;

        //find inputs of my stateMachine and enter their names(find from rive editor(inputs))
        hit = _stateMachineController.findInput("Hit");
        skins = _stateMachineController.findInput("numSkins");
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
                    child: Rive(
                      artboard: _artboard!,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  //Hit action
                  ElevatedButton(
                    onPressed: () {
                      //active hit for animation
                      hit!.change(true);
                    },
                    child: const Text(
                      "Hit",
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),

                  //change skin for animation
                  ElevatedButton(
                    onPressed: () {
                      if (numberOfSkins < 2) {
                        //show diffrente skin
                        numberOfSkins++;
                        skins!.change(numberOfSkins);
                      }
                    },
                    child: const Text(
                      "Skin+",
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  //change skin for animation
                  ElevatedButton(
                    onPressed: () {
                      if (numberOfSkins > 0) {
                        //back to old skins
                        numberOfSkins--;
                        skins!.change(numberOfSkins);
                      }
                    },
                    child: const Text(
                      "Skin-",
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
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
