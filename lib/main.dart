import 'package:flutter/material.dart';
import 'widgets/ConversationPage.dart';
import 'bitcoin-p2p/messaging.dart';
import 'bitcoin-p2p/anonMsgBloc.dart';

void main() {
  startServerSocket();
  print('what why');
  startNode();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _bloc = AnonMessageBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omega',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConversationPage(_bloc),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hi'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          children: [
            Expanded(child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your message',

                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              )
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
