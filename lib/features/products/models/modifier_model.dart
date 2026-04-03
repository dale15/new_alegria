import 'package:new_alegria/features/products/models/modifier_option_model.dart';

class Modifier {
  final String id;
  final String name;
  final bool isRequired;
  final bool isMultiple;
  final List<ModifierOption> options;

  Modifier({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.isMultiple,
    required this.options,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) {
    return Modifier(
      id: json['id'].toString(),
      name: json['name'],
      isRequired: json['isRequired'],
      isMultiple: json['isMultiple'],
      options:
          (json['options'] as List<dynamic>?)
              ?.map((o) => ModifierOption.fromJson(o))
              .toList() ??
          [],
    );
  }
}
