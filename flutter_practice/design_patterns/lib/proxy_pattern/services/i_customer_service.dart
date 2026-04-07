import '../models/customer_details.dart';

abstract class ICustomerService {
  Future<CustomerDetails> getCustomerDetails(String id);
}