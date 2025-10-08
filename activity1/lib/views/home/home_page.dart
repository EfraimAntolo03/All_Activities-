import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Stateless Hello World (Task 2)
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Pizza Hot!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            CustomButton(
              label: 'Go to Counter (Stateful)',
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const CounterPage())),
            ),
            const SizedBox(height: 8),
            const Text('Below shows Cupertino variant of button'),
            const SizedBox(height: 8),
            CustomButton(
              label: 'Cupertino Modal',
              useCupertino: true,
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (ctx) => CupertinoActionSheet(
                    title: const Text('Pizza Hot'),
                    message: const Text('This is a Cupertino-styled modal.'),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Stateful Hello World with counter (Task 3)
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hello World from StatefulWidget!'),
            Text('$count', style: Theme.of(context).textTheme.headlineMedium),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButton(
                label: 'Increment',
                onPressed: () => setState(() => count++),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
