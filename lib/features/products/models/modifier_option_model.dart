class ModifierOption {
  final String id;
  final String name;
  final double priceAdjustment;

  ModifierOption({
    required this.id,
    required this.name,
    required this.priceAdjustment,
  });

  factory ModifierOption.fromJson(Map<String, dynamic> json) {
    return ModifierOption(
      id: json['id'].toString(),
      name: json['name'],
      priceAdjustment: (json['priceAdjustment'] as num).toDouble(),
    );
  }
}
