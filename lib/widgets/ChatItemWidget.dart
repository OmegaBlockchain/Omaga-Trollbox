import 'package:flutter/material.dart';
import '../config/Palette.dart';
import 'package:intl/intl.dart';
import 'package:omega_trollbox/bitcoin-p2p/messaging.dart';

class ChatItemWidget extends StatelessWidget{
  CAnonMsg cAnonMsg;

  ChatItemWidget(this.cAnonMsg);
  @override
  Widget build(BuildContext context) {
      return Container(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    cAnonMsg.getMessage(),
                    style: TextStyle(color: Palette.textMessageColor),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                      color: Palette.primaryChatBubbleColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(right: 10.0),
                )
              ],
              mainAxisAlignment:
              MainAxisAlignment.end, // aligns the chatitem to right end
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm')
                          .format(DateTime.fromMillisecondsSinceEpoch(cAnonMsg.getTimestamp() * 1000)),
                      style: TextStyle(
                          color: Palette.greyColor,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal),
                    ),
                    margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                  )])
          ]));
  }
}