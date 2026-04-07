import 'dart:async';
import '../models/customer_details.dart';
import 'i_customer_service.dart';

class CustomerService implements ICustomerService {
  @override
  Future<CustomerDetails> getCustomerDetails(String id) async {
    await Future.delayed(Duration(seconds: 2)); // simulate API
    return CustomerDetails(id, "user$id@gmail.com");
  }
}