import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayersPage extends StatefulWidget {
  int numberOfPlayers;
  PlayersPage({super.key, required this.numberOfPlayers});

  @override
  State<StatefulWidget> createState() {
    return PlayersPageState();
  }
}

class PlayersPageState extends State<PlayersPage> {
  List<String> playerValues = [];
  List<int> playerTotal = [];
  List<List<int>> playerHistory = [];
  List<bool> inputVisible = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    playerValues =
        List<String>.generate(widget.numberOfPlayers, (index) => '0');
    playerTotal = List<int>.generate(widget.numberOfPlayers, (index) => 0);
    playerHistory =
        List<List<int>>.generate(widget.numberOfPlayers, (index) => []);
    inputVisible = List<bool>.generate(widget.numberOfPlayers, (index) => true);
    controllers = List<TextEditingController>.generate(
        widget.numberOfPlayers, (index) => TextEditingController());

    // Force landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // Reset to allow both orientations when leaving this page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // Dispose controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players Screen"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.numberOfPlayers,
            (index) => Column(
              children: [
                Text('Player ${index + 1}'),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Visibility(
                      visible: inputVisible[index],
                      child: SizedBox(
                        width: 200, // Set a fixed width or use Expanded
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (playerHistory[index].isNotEmpty)
                              Text('${playerValues[index]}-'),
                            Expanded(
                              child: TextField(
                                controller: controllers[index],
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (newValue) {
                                  setState(() {
                                    playerValues[index] = newValue;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Enter a value',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  int newValue =
                                      int.tryParse(playerValues[index]) ?? 0;
                                  playerTotal[index] += newValue;
                                  playerHistory[index].add(playerTotal[index]);
                                  playerValues[index] =
                                      '0'; // Reset the input field to '0'
                                  inputVisible[index] =
                                      false; // Hide the current input row
                                  controllers[index]
                                      .clear(); // Clear the TextField
                                  _closeKeyboard(); // Close the keyboard
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        playerHistory[index].length,
                        (historyIndex) {
                          int previousValue = historyIndex > 0
                              ? playerHistory[index][historyIndex - 1]
                              : 0;
                          return Text(
                            '$previousValue-${playerHistory[index][historyIndex]}',
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: !inputVisible[index],
                      child: SizedBox(
                        width: 200, // Set a fixed width or use Expanded
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('${playerTotal[index]}-'),
                            Expanded(
                              child: TextField(
                                controller: controllers[index],
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (newValue) {
                                  setState(() {
                                    playerValues[index] = newValue;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Enter a value',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  int newValue =
                                      int.tryParse(playerValues[index]) ?? 0;
                                  playerTotal[index] += newValue;
                                  playerHistory[index].add(playerTotal[index]);
                                  playerValues[index] =
                                      '0'; // Reset the input field to '0'
                                  controllers[index]
                                      .clear(); // Clear the TextField
                                  _closeKeyboard(); // Close the keyboard
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
