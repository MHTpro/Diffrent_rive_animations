import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:test_project/pages/animation_2.dart';

class YourWidget extends StatefulWidget {
  const YourWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  Artboard? _artboard;
  late StateMachineController _stateMachineController;

  //load the rive animation (function)
  Future<void> _loadRiveFile() async {
    final data = await rootBundle.load('assets/anim.riv');
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;

    setState(
      () {
        _artboard = artboard;
        _stateMachineController = StateMachineController.fromArtboard(
          _artboard!,
          //found the name in (Rive-Editor in website) then bottom left of the Screen.
          'State Machine 1',
        )!;
        _artboard!.addController(_stateMachineController);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    //rive animation(load)
    _loadRiveFile();
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Animation Example'),
      ),
      body: _artboard != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: SizedBox(
                      height: 300.0,
                      width: 300.0,

                      //Rive widget to show the animation
                      child: Rive(
                        artboard: _artboard!,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AnimationTwo(),
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
