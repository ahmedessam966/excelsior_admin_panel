class CarModel {
  final String carID;
  final String make;
  final String model;
  final String color;
  final String tier;
  final num year;
  final num rating;
  final bool bestSeller;
  final num? latestKM;
  final num pricePerDay;
  final num? pricePerExtraKM;
  final String? plates;
  final String? chassis;
  final bool? isRented;
  final String? branchName;
  final String? branchCoords;
  final String? image;
  final Map? specs;

  CarModel({
    required this.carID,
    required this.make,
    required this.model,
    required this.color,
    required this.tier,
    required this.year,
    required this.rating,
    required this.bestSeller,
    this.latestKM,
    required this.pricePerDay,
    this.pricePerExtraKM,
    this.plates,
    this.chassis,
    this.isRented,
    this.branchName,
    this.branchCoords,
    this.image,
    this.specs,
  });
}
