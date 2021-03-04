import 'package:flutter/material.dart';
import 'ChatItemWidget.dart';
import 'package:omega_trollbox/bitcoin-p2p/anonMsgBloc.dart';
import 'package:omega_trollbox/bitcoin-p2p/messaging.dart';

class ChatListWidget extends StatelessWidget{

  final AnonMessageBloc bloc;
  ChatListWidget(this.bloc);

  final ScrollController listScrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
        child: StreamBuilder(
          stream: bloc.cAnonMsg,
          initialData: List<CAnonMsg>(),
          builder: (BuildContext context, AsyncSnapshot<List<CAnonMsg>> snapshot) {
            return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) => ChatItemWidget(snapshot.data[index]),
                itemCount: snapshot.data.length,
                reverse: true,
                controller: listScrollController,
              );
          },
        ));
  }
}