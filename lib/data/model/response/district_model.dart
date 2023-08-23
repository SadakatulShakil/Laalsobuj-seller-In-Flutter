class District {
  final int id;
  final String district;

  District({required this.id, required this.district});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      district: json['district'],
    );
  }
}
