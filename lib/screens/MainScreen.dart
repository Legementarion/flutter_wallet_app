import 'package:flutter/material.dart';
import 'package:flutter_wallet_app/screens/CalendarScreen.dart';

class WalletScreenState extends State<WalletScreen> {
  List<String> _events = List<String>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final walletTextController = TextEditingController();
  final moneyTextController = TextEditingController();
  final eventTextController = TextEditingController();
  var daysRemain = "3";

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    moneyTextController.dispose();
    eventTextController.dispose();
    walletTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    walletTextController.text = "0"; // todo save this value to db
  }

  Widget _walletStatus(BuildContext context) {
    return new Container(
        height: 120.0,
        margin: const EdgeInsets.only(
            top: 16.0, bottom: 16.0, left: 24.0, right: 24.0),
        child: new Stack(
          children: <Widget>[
            new Container(
              height: 124.0,
              margin: new EdgeInsets.only(left: 46.0),
              decoration: new BoxDecoration(
                color: new Color(0xFF333366),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      new Padding(
                          padding: EdgeInsets.only(right: 16.0, top: 24.0),
                          child: Text(
                              "Current balance - " + walletTextController.text,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0))),
                      new Padding(
                          padding: EdgeInsets.only(right: 16.0, top: 24.0),
                          child: Text("Days ramein - " + daysRemain,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0)))
                    ])
                  ]),
            ),
            GestureDetector(
                child: new Container(
                  margin: new EdgeInsets.symmetric(vertical: 16.0),
                  alignment: FractionalOffset.centerLeft,
                  child: new Image(
                    image: new AssetImage("assets/wallet.png"),
                    height: 92.0,
                    width: 92.0,
                  ),
                ),
                onTap: () {
                  _addWalletMoney(context);
                }),
          ],
        ));
  }

  void _addWalletMoney(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctxt) => new AlertDialog(
              title: new Text("Add Money to wallet"),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: new TextField(
                    decoration: new InputDecoration(labelText: 'Income'),
                    keyboardType: TextInputType.number,
                    controller: moneyTextController,
                  ),
                )
              ]),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Add"),
                  onPressed: () {
                    setState(() {
                      _events.add(eventTextController.text);
                      walletTextController.text =
                          (int.parse(walletTextController.text) -
                                  int.parse(moneyTextController.text))
                              .toString();
                    });
                    Navigator.of(context).pop();
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
  }

  Widget _buildEvents() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider(); //todo init events from db
          return _buildRow(_events[index]);
        });
  }

  Widget _buildRow(String event) {
    final bool alreadySaved = _events.contains(event);

    return ListTile(
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      title: Text(
        event,
        style: _biggerFont,
      ),
      onTap: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wallet'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _walletStatus(context),
        new Expanded(
          child: _buildEvents(),
        )
      ]),
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
                          setState(() {
                            _events.add(eventTextController.text);
                            walletTextController.text =
                                (int.parse(walletTextController.text) -
                                        int.parse(moneyTextController.text))
                                    .toString();
                          });
                          Navigator.of(context).pop();
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
          return CalendarScreen();
        },
      ),
    );
  }
}

class WalletScreen extends StatefulWidget {
  @override
  WalletScreenState createState() => new WalletScreenState();
}
