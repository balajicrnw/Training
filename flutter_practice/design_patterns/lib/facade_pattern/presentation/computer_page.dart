import 'package:flutter/material.dart';
import '../facade/computer_facade.dart';
import '../data/computer_state.dart';

class ComputerPage extends StatefulWidget {
  const ComputerPage({super.key});

  @override
  State<ComputerPage> createState() => _ComputerPageState();
}

class _ComputerPageState extends State<ComputerPage> {
  final facade = ComputerFacade();
  final state = ComputerState();

  bool normalMode = false;
  bool upsMode = false;
  bool gamingMode = false;
  bool onlineMode = false;

  bool get isAnyOn => normalMode || upsMode || gamingMode || onlineMode;

  void toggleNormal(bool value) {
    if (value) {
      facade.startPC(state);
    } else {
      facade.shutdown(state);
    }
    setState(() => normalMode = value);
  }

  void toggleUPS(bool value) {
    if (value) {
      facade.startWithUPS(state);
    } else {
      facade.shutdown(state);
    }
    setState(() => upsMode = value);
  }

  void toggleGaming(bool value) {
    if (value) {
      facade.startGaming(state);
    } else {
      facade.shutdown(state);
    }
    setState(() => gamingMode = value);
  }

  void toggleOnline(bool value) {
    if (value) {
      facade.startOnline(state);
    } else {
      facade.shutdown(state);
    }
    setState(() => onlineMode = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Computer Facade")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            SwitchListTile(
              title: const Text("Normal Mode"),
              value: normalMode,
              onChanged: !isAnyOn || normalMode ? toggleNormal : null,
            ),

            SwitchListTile(
              title: const Text("UPS Mode"),
              value: upsMode,
              onChanged: !isAnyOn || upsMode ? toggleUPS : null,
            ),

            SwitchListTile(
              title: const Text("Gaming Mode"),
              value: gamingMode,
              onChanged: !isAnyOn || gamingMode ? toggleGaming : null,
            ),

            SwitchListTile(
              title: const Text("Online Mode"),
              value: onlineMode,
              onChanged: !isAnyOn || onlineMode ? toggleOnline : null,
            ),

            const SizedBox(height: 30),

            Text("CPU: ${state.cpuOn}"),
            Text("GPU: ${state.gpuOn}"),
            Text("Internet: ${state.internetOn}"),
            Text("UPS: ${state.upsOn}"),
          ],
        ),
      ),
    );
  }
}