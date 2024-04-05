import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laugh Hub',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: JokeGenerator(),
    );
  }
}

class JokeGenerator extends StatefulWidget {
  @override
  _JokeGeneratorState createState() => _JokeGeneratorState();
}

class _JokeGeneratorState extends State<JokeGenerator> {
  List<String> jokes = [
    "Why don't scientists trust atoms? Because they make up everything!",
    "Parallel lines have so much in common. It’s a shame they’ll never meet.",
    "Why did the scarecrow win an award? Because he was outstanding in his field!",
    "I told my wife she was drawing her eyebrows too high. She looked surprised.",
    "What's orange and sounds like a parrot? A carrot!",
    "I'm reading a book on anti-gravity. It's impossible to put down!",
    "Why don't eggs tell jokes? Because they'd crack each other up!",
  ];

  List<String> darkHumorJokes = [
    "Why was the math book sad? Because it had too many problems.",
    "Why was the belt arrested? For holding up a pair of pants!",
    "Why did the tomato turn red? Because it saw the salad dressing!",
    "Why did the scarecrow get a promotion? Because he was outstanding in his field!",
    "What's the difference between a snowman and a snowwoman? Snowballs!",
    "I used to play piano by ear, but now I use my hands.",
    "What did the big flower say to the little flower? Hi, bud!",
  ];

  List<String> dadJokes = [
    "Why don't skeletons fight each other? They don't have the guts.",
    "What do you call fake spaghetti? An impasta!",
    "What's brown and sticky? A stick!",
    "How does a penguin build its house? Igloos it together!",
    "What do you call a belt made of watches? A waist of time!",
    "I told my wife she should embrace her mistakes. She gave me a hug.",
    "Why did the math book look sad? Because it had too many problems.",
  ];

  List<String> punJokes = [
    "I'm on a seafood diet. I see food and I eat it!",
    "Why did the scarecrow win an award? Because he was outstanding in his field!",
    "I used to be a baker, but I couldn't make enough dough.",
    "I'm trying to organize a hide and seek competition, but it's hard to find good players – they're always hiding!",
    "Why did the bicycle fall over? It was two-tired!",
    "I'm reading a book about anti-gravity. It's impossible to put down!",
    "I told my wife she was drawing her eyebrows too high. She looked surprised.",
  ];

  String currentJoke = '';
  Set<String> likedJokes = Set();
  TextEditingController customJokeController = TextEditingController();
  String? jokeType;

  void generateRandomJoke() {
    List<String> jokeList;
    if (jokeType == null) {
      jokeList = jokes + darkHumorJokes + dadJokes + punJokes;
    } else if (jokeType == 'dark') {
      jokeList = darkHumorJokes;
    } else if (jokeType == 'dad') {
      jokeList = dadJokes;
    } else {
      jokeList = punJokes;
    }

    setState(() {
      currentJoke = jokeList[Random().nextInt(jokeList.length)];
    });
  }

  void addToFavorites() {
    setState(() {
      likedJokes.add(currentJoke);
    });
  }

  void addCustomJoke() {
    String customJoke = customJokeController.text.trim();
    if (customJoke.isNotEmpty && jokeType != null) {
      setState(() {
        if (jokeType == 'dad') {
          dadJokes.add(customJoke);
        } else if (jokeType == 'dark') {
          darkHumorJokes.add(customJoke);
        } else if (jokeType == 'pun') {
          punJokes.add(customJoke);
        }
      });
      customJokeController.clear();
      jokeType = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laugh Hub'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Jokes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('Dark Humor'),
              onTap: () {
                setState(() {
                  jokeType = 'dark';
                });
                generateRandomJoke();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.family_restroom),
              title: Text('Dad Jokes'),
              onTap: () {
                setState(() {
                  jokeType = 'dad';
                });
                generateRandomJoke();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tag_faces),
              title: Text('Pun Jokes'),
              onTap: () {
                setState(() {
                  jokeType = 'pun';
                });
                generateRandomJoke();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Add functionality for home section
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesScreen(likedJokes)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: Text('Add Custom Joke'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: customJokeController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your joke',
                                ),
                              ),
                              RadioListTile<String>(
                                title: Text('Dad Joke'),
                                value: 'dad',
                                groupValue: jokeType,
                                onChanged: (value) {
                                  setState(() {
                                    jokeType = value!;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: Text('Dark Humor'),
                                value: 'dark',
                                groupValue: jokeType,
                                onChanged: (value) {
                                  setState(() {
                                    jokeType = value!;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: Text('Pun Joke'),
                                value: 'pun',
                                groupValue: jokeType,
                                onChanged: (value) {
                                  setState(() {
                                    jokeType = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                addCustomJoke();
                                Navigator.of(context).pop();
                              },
                              child: Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://cdn.pixabay.com/photo/2024/03/11/17/09/ai-generated-8627213_1280.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentJoke.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        currentJoke,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        icon: Icon(
                          likedJokes.contains(currentJoke)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: likedJokes.contains(currentJoke)
                              ? Colors.red
                              : Colors.white,
                        ),
                        onPressed: addToFavorites,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: generateRandomJoke,
                child: Text('Generate Joke',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final Set<String> likedJokes;

  FavoritesScreen(this.likedJokes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Center(
        child: ListView(
          children: likedJokes.map((joke) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  joke,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
