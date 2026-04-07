import '../models/customer_details.dart';
import 'i_customer_service.dart';

class CustomerServiceProxy implements ICustomerService {
  final ICustomerService service;
  final Map<String, CustomerDetails> cache = {};

  CustomerServiceProxy(this.service);

  @override
  Future<CustomerDetails> getCustomerDetails(String id) async {
    if (cache.containsKey(id)) {
      print("From Cache");
      return cache[id]!;
    }

    print("From API");
    final data = await service.getCustomerDetails(id);
    cache[id] = data;
    return data;
  }
}