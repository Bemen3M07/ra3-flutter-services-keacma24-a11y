import 'package:flutter/material.dart';
import '../controllers/joke_controller.dart';
import '../models/joke_model.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  JokeScreenState createState() => JokeScreenState();
}

class JokeScreenState extends State<JokeScreen> {
  // Instància del Controlador
  final JokeController _jokeController = JokeController();

  // Variables d'estat (UI)
  Joke? _currentJoke;
  bool _isLoading = false;

  // Funció que connecta la Vista amb el Controlador
  Future<void> _loadNewJoke() async {
    setState(() {
      _isLoading = true;
    });

    final nuevoChiste = await _jokeController.fetchNextJoke();

    setState(() {
      _currentJoke = nuevoChiste;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke API'),
        backgroundColor: const Color.fromARGB(255, 187, 180, 199),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _buildContent(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loadNewJoke,
        label: const Text("Otro chiste?"),
        icon: const Icon(Icons.sentiment_very_satisfied),
        backgroundColor: const Color.fromARGB(255, 199, 191, 212),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  Widget _buildContent() {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }

    if (_currentJoke == null) {
      return const Text(
        "Aún no hay ningún chiste.\n¡Presiona el botón!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.grey),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  _currentJoke!.setup,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Icon(Icons.arrow_downward, color: Colors.deepPurple),
                const SizedBox(height: 20),
                Text(
                  _currentJoke!.punchline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18, 
                    color: Colors.deepPurple, 
                    fontStyle: FontStyle.italic
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}