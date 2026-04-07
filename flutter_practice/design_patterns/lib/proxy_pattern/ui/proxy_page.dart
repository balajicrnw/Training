import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/customer_service.dart';
import '../services/customer_service_proxy.dart';

class ProxyPage extends StatefulWidget {
  @override
  _ProxyPageState createState() => _ProxyPageState();
}

class _ProxyPageState extends State<ProxyPage> {
  final proxy = CustomerServiceProxy(CustomerService());

  final List<Customer> customers = List.generate(
    5,
    (i) => Customer("$i", "Customer $i"),
  );

  // 🔥 Show dialog with Proxy logic
  Future<void> showCustomerDetails(Customer customer) async {
    bool isCached = proxy.cache.containsKey(customer.id);

    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: proxy.getCustomerDetails(customer.id),
          builder: (context, snapshot) {
            // ⏳ Loading state (only for API call)
            if (!snapshot.hasData) {
              return AlertDialog(
                title: Text(customer.name),
                content: SizedBox(
                  height: 80,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            final data = snapshot.data!;

            return AlertDialog(
              title: Text(customer.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Email: ${data.email}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),

                  // ⚡ Cache vs API indicator
                  Text(
                    isCached ? "⚡ Loaded from Cache" : "⏳ Loaded from API",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proxy Pattern - Customers"),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(customer.name[0]),
              ),
              title: Text(customer.name),
              subtitle: Text("Tap to view details"),
              trailing: Icon(Icons.info_outline),
              onTap: () => showCustomerDetails(customer),
            ),
          );
        },
      ),
    );
  }
}