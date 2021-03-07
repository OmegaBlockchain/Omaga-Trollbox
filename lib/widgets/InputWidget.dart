import 'package:flutter/material.dart';
import '../config/Palette.dart';
import '../bitcoin-p2p/messaging.dart';
import 'package:omega_trollbox/bitcoin-p2p/anonMsgBloc.dart';

class InputWidget extends StatelessWidget {

  final AnonMessageBloc bloc;
  InputWidget(this.bloc);

  final TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face, color: Colors.white),
                color: Colors.white,
              ),
            ),
            color: Colors.white,
          ),

          // Text input
          Flexible(
            child: Container(
              child: TextField(
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Palette.primaryTextColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Palette.greyColor),
                ),
              ),
            ),
          ),

          // Send Message Button
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => {
                  if (!isAllSpaces(textEditingController.text)) {
                    bloc.sendAnonMsgEventSink.add(textEditingController.text),
                    textEditingController.clear()
                  }
                },
                color: Palette.primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(color: Palette.greyColor, width: 0.5)),
          color: Colors.white),
    );
  }

  bool isAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    if(output == '') {
      return true;
    }
    return false;
  }
}
