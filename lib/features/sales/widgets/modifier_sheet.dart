import 'package:flutter/material.dart';
import 'package:new_alegria/features/sales/models/selected_product_modifier.dart';

class ModifierDialog extends StatefulWidget {
  final dynamic product;
  final Function(List<SelectedModifier>, double) onConfirm;

  const ModifierDialog({
    super.key,
    required this.product,
    required this.onConfirm,
  });

  @override
  State<ModifierDialog> createState() => _ModifierDialogState();
}

class _ModifierDialogState extends State<ModifierDialog> {
  final Map<String, SelectedModifier> _selectedOptions = {};
  double _extraPrice = 0;

  @override
  Widget build(BuildContext context) {
    final modifiers = widget.product.modifiers;
    final total = widget.product.sellingPrice + _extraPrice;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      constraints: BoxConstraints(maxWidth: 600),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// TITLE
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// MODIFIERS (GRID SECTIONS)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView(
                children: modifiers.map<Widget>((modifier) {
                  return _buildModifierGrid(modifier);
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            /// CONFIRM BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  widget.onConfirm(
                    _selectedOptions.values.toList(),
                    _extraPrice,
                  );
                },
                child: Text(
                  "Add • ₱${total.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModifierGrid(dynamic modifier) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            modifier.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),

          const SizedBox(height: 8),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: modifier.options.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 👉 change to 3 for tablet
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (_, index) {
              final option = modifier.options[index];
              final entry = _selectedOptions[modifier.id];
              final isSelected = entry?.optionName == option.name;

              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  setState(() {
                    final current = _selectedOptions[modifier.id];

                    if (current?.optionName == option.name) {
                      _selectedOptions.remove(modifier.id); // 👈 deselect
                    } else {
                      _selectedOptions[modifier.id] = SelectedModifier(
                        modifierName: modifier.name,
                        optionName: option.name,
                        priceAdjustment: option.priceAdjustment.toDouble(),
                      );
                    }

                    _extraPrice = 0;
                    for (var entry in _selectedOptions.values) {
                      _extraPrice += entry.priceAdjustment;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.orange.withOpacity(0.1)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Colors.orange : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      if (option.priceAdjustment > 0)
                        Text(
                          "+₱${option.priceAdjustment.toStringAsFixed(0)}",
                          style: const TextStyle(fontSize: 14),
                        ),

                      if (isSelected)
                        const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.check,
                            size: 14,
                            color: Colors.orange,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
