import 'dart:async';
import 'dart:isolate';

import 'package:blocisolates/bloc_isolate.dart';
import 'package:blocisolates/events.dart';
import 'package:blocisolates/states.dart';

class Bloc {
  final StreamController<Event> _eventController;
  final StreamController<State> _stateController;
  final Isolate _isolate;
  final ReceivePort _receivePort;
  Stream<State>? _state;

  Bloc._({
    required StreamController<Event> eventController,
    required StreamController<State> stateController,
    required Isolate isolate,
    required ReceivePort receivePort,
  })  : _eventController = eventController,
        _stateController = stateController,
        _isolate = isolate,
        _receivePort = receivePort;

  Stream<State> get state =>
      _state ??= _stateController.stream.asBroadcastStream();
  StreamSink<Event> get event => _eventController.sink;

  static Future<Bloc> init() async {
    final eventController = StreamController<Event>();
    final stateController = StreamController<State>();
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      blocIsolate,
      receivePort.sendPort,
    );

    receivePort.listen((message) {
      if (message is SendPort) {
        eventController.stream.listen((event) {
          message.send(event);
        });
      } else if (message is State) {
        stateController.add(message);
      }
    });

    return Bloc._(
      eventController: eventController,
      stateController: stateController,
      isolate: isolate,
      receivePort: receivePort,
    );
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
    _receivePort.close();
    _isolate.kill();
  }
}
