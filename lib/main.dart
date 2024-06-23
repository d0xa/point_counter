import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PlayersPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlayerSelectionScreen(),
    );
  }
}

class PlayerSelectionScreen extends StatefulWidget {
  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  int numberOfPlayers = 1;

  void setNumberOfPlayers(int value) {
    setState(() {
      numberOfPlayers = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Selection'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Number of Players:'),
            const SizedBox(height: 10),
            IntWheel(onChanged: setNumberOfPlayers),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (numberOfPlayers > 0 ) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlayersPage(numberOfPlayers: numberOfPlayers),
                    ),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class IntWheel extends StatefulWidget {
  final Function(int) onChanged;

  const IntWheel({Key? key, required this.onChanged}) : super(key: key);

  @override
  _IntWheelState createState() => _IntWheelState();
}

class _IntWheelState extends State<IntWheel> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => setState(() {
            if (selectedValue > 0) {
              selectedValue--;
            }
            widget.onChanged(selectedValue);
          }),
        ),
        Text('$selectedValue'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => setState(() {
            selectedValue++;
            widget.onChanged(selectedValue);
          }),
        ),
      ],
    );
  }
}
