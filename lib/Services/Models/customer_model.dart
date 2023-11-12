class CustomerModel {
  final String customerID;
  final String name;
  final String email;
  final String phone;
  final String pidNumber;
  final String licenseNumber;
  final String address;
  final List contracts;

  CustomerModel(
      {required this.customerID,
      required this.name,
      required this.email,
      required this.phone,
      required this.pidNumber,
      required this.licenseNumber,
      required this.address,
      required this.contracts});
}
