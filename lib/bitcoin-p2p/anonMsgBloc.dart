// Copyright (c) 2021 Kolby Moroz Liebl
// Distributed under the MIT software license, see the accompanying
// file LICENSE or http://www.opensource.org/licenses/mit-license.php.

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'messaging.dart';
import 'util.dart';

class AnonMessageBloc {
  int _nodeCount;
  int _messageCount;

  final _nodeCountStateController = StreamController<int>();
  StreamSink<int> get _inNodeCount => _nodeCountStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<int> get nodeCount => _nodeCountStateController.stream;

  // Send message

  final _sendAnonMsgEventController = StreamController<String>();
  // For events, exposing only a sink which is an input
  Sink<String> get sendAnonMsgEventSink => _sendAnonMsgEventController.sink;

  // get messages and display

  final _anonMsgStateController = StreamController<List<CAnonMsg>>();
  StreamSink<List<CAnonMsg>> get _inCAnonMsg => _anonMsgStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<List<CAnonMsg>> get cAnonMsg => _anonMsgStateController.stream;

  AnonMessageBloc() {
    _nodeCount = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (nodes.length != _nodeCount) {
        _nodeCount = nodes.length;
        _inNodeCount.add(_nodeCount);
      }
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mapAnonMsg.length != _messageCount) {
        _messageCount = mapAnonMsg.length;
        _inCAnonMsg.add(sortAnonMsg(mapAnonMsg.toList((entry) => entry.value)));
      }
    });

    Timer.periodic(Duration(minutes: 1), (timer) {
      removeOldAnonMessage();
    });

    _sendAnonMsgEventController.stream.listen(_sendAnonMsg);
  }

  void _sendAnonMsg(String string) {
    sendAnonMessage(string);
    _inCAnonMsg.add(sortAnonMsg(mapAnonMsg.toList((entry) => entry.value)));
  }

  dispose() {
    _nodeCountStateController.close();
    _sendAnonMsgEventController.close();
    _anonMsgStateController.close();
  }
}

extension ListFromMap<Key, Element> on Map<Key, Element> {
  List<T> toList<T>(
      T Function(MapEntry<Key, Element> entry) getElement) =>
      entries.map(getElement).toList();
}