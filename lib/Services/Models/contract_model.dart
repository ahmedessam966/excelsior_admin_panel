class ContractModel {
  final String contractID;
  final String contractDate;
  final String customerID;
  final String customerName;
  final String duration;
  final String carID;
  final num downPayment;
  final bool status;
  final String carName;

  ContractModel(
      {required this.contractID,
      required this.contractDate,
      required this.customerID,
      required this.customerName,
      required this.duration,
      required this.carID,
      required this.downPayment,
      required this.status,
      required this.carName});
}
