import 'package:flutter/material.dart';
import 'PlayersPage.dart';

class PlayerNamesPage extends StatefulWidget {
  final int numberOfPlayers;

  PlayerNamesPage({required this.numberOfPlayers});

  @override
  _PlayerNamesPageState createState() => _PlayerNamesPageState();
}

class _PlayerNamesPageState extends State<PlayerNamesPage> {
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    controllers = List<TextEditingController>.generate(
      widget.numberOfPlayers,
      (index) => TextEditingController(text: 'Player ${index + 1}'),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _navigateToPlayersPage() {
    List<String> playerNames =
        controllers.map((controller) => controller.text).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayersPage(
          numberOfPlayers: widget.numberOfPlayers,
          playerNames: playerNames,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Player Names'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.numberOfPlayers,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controllers[index],
                      decoration: InputDecoration(
                        labelText: 'Player ${index + 1} Name',
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToPlayersPage,
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
