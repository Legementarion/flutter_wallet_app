import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Wallet Calculator ',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: WalletScreen(),
    );
  }
}

class WalletScreenState extends State<WalletScreen> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = Set<WordPair>();

  final moneyTextController = TextEditingController();
  final eventTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    moneyTextController.dispose();
    eventTextController.dispose();
    super.dispose();
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctxt) => new AlertDialog(
                    title: new Text("Add Event"),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text("How many and where you spend?"),
                          new Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: new TextField(
                              decoration:
                                  new InputDecoration(labelText: 'Money ?'),
                              keyboardType: TextInputType.number,
                              controller: moneyTextController,
                            ),
                          ),
                          new TextField(
                            decoration:
                                new InputDecoration(labelText: 'Event ?'),
                            controller: eventTextController,
                          )
                        ]),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Add"),
                        onPressed: () {
                          //todo add
                        },
                      ),
                      new FlatButton(
                        child: new Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
        },
        tooltip: 'AddMoney',
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

class WalletScreen extends StatefulWidget {
  @override
  WalletScreenState createState() => new WalletScreenState();
}
