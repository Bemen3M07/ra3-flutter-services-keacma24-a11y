import '../models/joke_model.dart';
import '../services/joke_service.dart';

class JokeController {
  final JokeService _service = JokeService();
  
  Future<Joke?> fetchNextJoke() async {
    try {
      return await _service.getJoke();
    } catch (e) {
      return null;
    }
  }
}