# SMaC Dart

Adds State Managements Components (SMaC) that helps you to torn apart the Business Logics of Component (BLoC) from the `State`, but still allowing them to be accessed by it.

## Getting Started

Let's use this page as an example:

``` dart
// counter_page.dart
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
  });
    
  State<_CounterPageState> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Text(
          'Times pressed the button: $counter',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState({
            counter++;
          });
        },
      ),
    );
  }
}
```

First, we need to create a new class that will extend `Smac`, and write the logic in it:
```dart
// counter_page_smac.dart
import 'package:smac_dart/smac_dart.dart';

class CounterPageSmac extends Smac {
  // Let the variable private to avoid accidental changes coming from the widget
  int _counter = 0;

  void incrementCounter() {
    _counter++;
    // Smac supports the same reactivities of the [ChangeNotifier] class
    notifyListeners();
  }
}
```

Then, add the `GetSmacMixin` to bind the SMaC to the State, and replace the parameters and logics from the ones inside the SMaC:

```dart
// counter_page.dart
import 'package:flutter/material.dart';
import 'package:smac_dart/smac_dart.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
  });
    
  State<_CounterPageState> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> 
    with GetSmacMixin<CounterPage, CounterPageSmac> {
  // Binds the SMaC instance
  CounterPageSmac createSmac() => CounterPageSmac();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Text(
          // Replaced [counter] for [smac.counter]
          'Times pressed the button: ${smac.counter}',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        // Replaced the old logic for the one from the SMaC
        onPressed: smac.incrementCounter,
      ),
    );
  }
}
```

## Async SMaC

If you want a simple way to manage the state that have asynchronous logic, you can also use the AsyncSmac in conjunction with AsyncSmacBuilder.

Both the AsyncSmac and the AsyncSmacBuilder have reactivity for 4 default states:
* Waiting -> When the asynchrony is not started.
* Loading -> When the asynchrony is running.
* Success -> When the asynchrony suceeded.
* Errored -> Whent the asynchrony failed, and contains an error.

You can manually change the AsyncSmac state, or use the `waitFor()` function to have a default behavior to asynchrony.

When the asynchrony fails, the error that triggers the failure is stored inside the AsyncSmac, and you can choose whether the error is thrown or not.

## Questions and Problems

The **issues** channel can be used for questioning, report problems or make suggestions.