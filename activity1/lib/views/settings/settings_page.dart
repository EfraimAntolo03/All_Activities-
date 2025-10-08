import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool useCupertino = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    if (useCupertino) {
      // Cupertino version of same UI (Task 5)
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(middle: Text('Settings')),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cupertino Mode'),
                    CupertinoSwitch(
                      value: useCupertino,
                      onChanged: (v) => setState(() => useCupertino = v),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Notifications'),
                    CupertinoSwitch(
                      value: notifications,
                      onChanged: (v) => setState(() => notifications = v),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Show Cupertino Dialog',
                  useCupertino: true,
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                        title: const Text('Pizza Hot'),
                        content: const Text('This is a Cupertino alert.'),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Material version of same UI (Task 5)
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cupertino Mode'),
              Switch(
                value: useCupertino,
                onChanged: (v) => setState(() => useCupertino = v),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Notifications'),
              Switch(
                value: notifications,
                onChanged: (v) => setState(() => notifications = v),
              ),
            ],
          ),
          const SizedBox(height: 24),
          CustomButton(
            label: 'Show Material Dialog',
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Pizza Hot'),
                  content: const Text('This is a Material alert.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
