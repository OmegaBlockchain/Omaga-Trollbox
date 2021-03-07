import 'package:flutter/material.dart';
import 'package:omega_trollbox/config/Palette.dart';
import 'ChatAppBar.dart';
import 'ChatListWidget.dart';
import 'InputWidget.dart';
import 'package:omega_trollbox/bitcoin-p2p/anonMsgBloc.dart';

class ConversationPage extends StatefulWidget {
  final AnonMessageBloc bloc;

  ConversationPage(this.bloc);
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 10.0,
            //elevation: 5.0,
            title: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/OMEGA_cir.png',
                      height: 30,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Omega TrollBox'),
                  ),
              ]
            ),
            backgroundColor: Palette.appBar,
            actions: <Widget> [
              StreamBuilder(
                stream: widget.bloc.nodeCount,
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return IconButton(icon: Icon((snapshot.data == 0) ? Icons.wifi_off : Icons.wifi, color: (snapshot.data >= 4) ? Colors.green : (snapshot.data >= 2) ? Colors.orange : Colors.yellow), onPressed: () {
                    showAlertDialog(context, snapshot);
                  });
                },
              )
            ],
          ),
            body: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  ChatListWidget(widget.bloc),//Chat list
                  InputWidget(widget.bloc) // The input widget
                ],
              ),
            ]
            )
        )
    );
  }
}

showAlertDialog(BuildContext context, AsyncSnapshot<int> snapshot) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Node Count"),
    content: Text("You are connected to ${snapshot.data} nodes."),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}