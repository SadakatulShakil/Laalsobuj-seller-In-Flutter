class Upazila {
  final int id;
  final int district;
  final String upazila;

  Upazila({required this.id, required this.district, required this.upazila});

  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(
      id: json['id'],
      district: json['district'],
      upazila: json['upazila'],
    );
  }
}
