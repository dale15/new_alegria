class DiscountModel {
  final int id;
  final String name;
  final String type; // "fixed" or "percent"
  final num value;
  final bool isActive;

  const DiscountModel({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
    required this.isActive,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      value: json['value'] as num,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'value': value,
      'isActive': isActive,
    };
  }

  bool get isPercent => type == 'percent';
  bool get isFixed => type == 'fixed';
}
