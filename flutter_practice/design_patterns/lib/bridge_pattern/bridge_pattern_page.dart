import 'package:flutter/material.dart';

import 'package:design_patterns/bridge_pattern/core/models/user.dart';
import 'package:design_patterns/bridge_pattern/data/repository/user_repository.dart';
import 'package:design_patterns/bridge_pattern/data/storage/cloud_storage.dart';
import 'package:design_patterns/bridge_pattern/data/storage/local_storage.dart';

class BridgePatternPage extends StatefulWidget {
  const BridgePatternPage({super.key});

  @override
  State<BridgePatternPage> createState() => _BridgePatternPageState();
}

class _BridgePatternPageState extends State<BridgePatternPage> {
  late UserRepository repo;

  bool isCloud = false;

  List<User> allUsers = [];
  List<User> users = [];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _setRepository();
    _loadInitialData();
  }

  // 🔌 Switch storage (Bridge in action)
  void _setRepository() {
    repo = UserRepository(
      isCloud ? CloudStorage() : LocalStorage(),
    );
  }

  // 📥 Load all users from storage
  Future<void> _loadInitialData() async {
    allUsers = await repo.fetchUsers();

    setState(() {
      users = [];
      currentIndex = 0;
    });
  }

  // 🔄 Toggle Local ↔ Cloud
  Future<void> _switchStorage(bool value) async {
    setState(() {
      isCloud = value;
      _setRepository();
    });

    await _loadInitialData();
  }

  // 👉 Load users one by one
  void _loadNextUser() {
    if (currentIndex >= allUsers.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🚫 No more users to load"),
        ),
      );
      return;
    }

    setState(() {
      users.add(allUsers[currentIndex]);
      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bridge Pattern Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔄 STORAGE SWITCH
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Use Cloud Storage",
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isCloud,
                  onChanged: _switchStorage,
                ),
              ],
            ),

            const SizedBox(height: 10),

            // BUTTONS
            Row(
              children: [
                ElevatedButton(
                  onPressed: _loadNextUser,
                  child: const Text("Load Next User"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Users:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // 📋 USER LIST
            Expanded(
              child: users.isEmpty
                  ? const Center(
                      child: Text("No users loaded yet"),
                    )
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              isCloud ? Icons.cloud : Icons.storage,
                            ),
                            title: Text(user.name),
                            subtitle: Text("ID: ${user.id}"),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}