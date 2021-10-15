import 'dart:async';

enum CounterAction {
  increment,
  decrement,
  reset,
}

class CounterBloc {
  int counter = 0;
  final _stateStreamController = StreamController<
      int>.broadcast(); //.broadcast() is used to set multiple listener.
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;

    //Broadcasting Testing for counter sink
    counterStream.listen((event) {
      print("Counter Stream Event");
      print(event);
    });

    eventStream.listen(
      (event) {
        if (event == CounterAction.increment) {
          counter++;
        } else if (event == CounterAction.decrement && counter > 0) {
          counter--;
        } else if (event == CounterAction.reset) {
          counter = 0;
        }
        counterSink.add(counter);
      },
    );
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
