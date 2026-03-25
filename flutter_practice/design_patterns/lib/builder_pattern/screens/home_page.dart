import 'package:flutter/material.dart';
import '../builder/gaming_pc_builder.dart';
import '../builder/office_pc_builder.dart';
import '../director/pc_maker.dart';
import '../model/pc.dart';
import '../model/component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PC? _pc;
  String _selected = 'Gaming';

  void _build() {
    final builder =
        _selected == 'Gaming' ? GamingPCBuilder() : OfficePCBuilder();
    setState(() => _pc = PCMaker(builder).buildFullPC());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Builder Pattern'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Selector ──
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select PC Type',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: ['Gaming', 'Office'].map((type) {
                        final selected = _selected == type;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text(type),
                              selected: selected,
                              onSelected: (_) =>
                                  setState(() => _selected = type),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _build,
              icon: const Icon(Icons.build_rounded),
              label: const Text('Build PC'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            // ── Result ──
            if (_pc != null) ...[
              Text(
                '${_pc!.type} — \$${_pc!.totalPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: _pc!.components.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (ctx, i) {
                    final Component c = _pc!.components[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            colorScheme.primaryContainer,
                        child: Text(
                          c.name[0],
                          style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(c.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(c.spec),
                      trailing: c.price > 0
                          ? Text('\$${c.price.toStringAsFixed(0)}',
                              style: TextStyle(color: colorScheme.primary))
                          : const Text('Included',
                              style: TextStyle(color: Colors.grey)),
                    );
                  },
                ),
              ),
            ] else
              const Expanded(
                child: Center(
                  child: Text(
                    'Choose a PC type and tap "Build PC".',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
