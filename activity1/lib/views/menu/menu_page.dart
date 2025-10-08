import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../services/pizza_service.dart';
import '../../widgets/custom_button.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pizzas = const PizzaService().getFeaturedPizzas();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Menu',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              itemCount: pizzas.length,
              itemBuilder: (context, index) {
                final p = pizzas[index];
                return _PizzaCard(
                  name: p.name,
                  desc: p.description,
                  price: p.price,
                  imageUrl: p.imageUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PizzaCard extends StatelessWidget {
  final String name;
  final String desc;
  final double price;
  final String imageUrl;

  const _PizzaCard({
    required this.name,
    required this.desc,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: _PizzaImage(imageUrl: imageUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  ₱${price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 120,
                      child: CustomButton(
                        label: 'Add to Cart',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PizzaImage extends StatelessWidget {
  final String imageUrl;
  const _PizzaImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('icon:')) {
      return Container(
        color: Colors.red.shade50,
        child: const Center(
          child: Icon(Icons.local_pizza, size: 72, color: Colors.redAccent),
        ),
      );
    }
    return Image.network(imageUrl, fit: BoxFit.cover);
  }
}
