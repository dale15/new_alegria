import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_alegria/features/products/models/category_model.dart';
import 'package:new_alegria/features/products/models/product_model.dart';
import 'package:new_alegria/features/products/view_models/category_view_model.dart';
import 'package:new_alegria/features/products/view_models/product_state.dart';
import 'package:new_alegria/features/products/view_models/product_view_model.dart';
import 'package:new_alegria/features/sales/models/cart_item.dart';
import 'package:new_alegria/features/sales/view_models/cart_view_model.dart';
import 'package:new_alegria/features/sales/widgets/modifier_sheet.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  void onProductTap(BuildContext context, ProductModel product, WidgetRef ref) {
    final cartVm = ref.read(cartViewModelProvider.notifier);

    if (product.modifiers.isEmpty) {
      cartVm.addItem(
        CartItem(product: product, quantity: 1, selectedOptions: []),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ModifierSheet(
          product: product,
          onConfirm: (selectedOptions, extraPrice) {
            cartVm.addItem(
              CartItem(
                product: product,
                quantity: 1,
                selectedOptions: selectedOptions,

                /// 👇 IMPORTANT (you likely need this)
                extraPrice: extraPrice,
              ),
            );

            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productViewModelProvider);
    final vm = ref.read(productViewModelProvider.notifier);
    final cartVm = ref.read(cartViewModelProvider.notifier);

    final categoriesAsync = ref.watch(categoryViewModelProvider);

    return Column(
      children: [
        _buildHeader(vm),
        _buildSearchBar(vm),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: _buildCategoryChips(categoriesAsync, vm, state),
        ),
        Expanded(child: _buildProductGrid(vm, cartVm, ref)),
      ],
    );
  }

  Widget _buildHeader(ProductViewModel vm) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Alegria Bakeshop",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(vm.formattedDate, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ProductViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: vm.setSearchQuery,
        decoration: InputDecoration(
          hintText: "Search products...",
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildCategoryChips(
    AsyncValue<List<CategoryModel>> categoriesAsync,
    ProductViewModel vm,
    ProductState state,
  ) {
    return categoriesAsync.when(
      data: (categories) {
        final allCategories = [
          CategoryModel(id: 0, name: 'All', description: ''),
          ...categories,
        ];

        return SizedBox(
          height: 50,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            scrollDirection: Axis.horizontal,
            itemCount: allCategories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, index) {
              final category = allCategories[index];

              final isSelected = category.id == state.selectedCategoryId;

              return ChoiceChip(
                label: Text(category.name),
                selected: isSelected,
                selectedColor: Colors.orange.shade100,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.orange : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (_) => vm.selectCategory(category.id),
              );
            },
          ),
        );
      },

      loading: () => const SizedBox(
        height: 50,
        child: Center(child: CircularProgressIndicator()),
      ),

      error: (e, _) => SizedBox(
        height: 50,
        child: Center(child: Text('Error loading categories')),
      ),
    );
  }

  Widget _buildProductGrid(
    ProductViewModel vm,
    CartViewModel cartVm,
    WidgetRef ref,
  ) {
    final products = vm.filteredProducts;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 👈 adjust for POS layout
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return _buildProductCard(context, ref, product);
      },
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    WidgetRef ref,
    ProductModel product,
  ) {
    return GestureDetector(
      onTap: () => onProductTap(context, product, ref),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.local_cafe, size: 40),

            Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            Text(
              "₱${product.sellingPrice.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),

            /// 🔥 Optional: show indicator if has modifiers
            if (product.modifiers.isNotEmpty)
              const Icon(Icons.tune, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
