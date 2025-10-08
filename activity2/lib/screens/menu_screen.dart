import 'package:flutter/material.dart';
import '../widgets/pizza_image_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Classic',
    'Premium',
    'Vegetarian',
    'Spicy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Activity 3: Container with padding, margin, and background color around Text widget
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE74C3C).withValues(alpha: 0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  '🍕 Fresh Pizza Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Handcrafted with love • Hot & Fresh • 25min delivery',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: const Color(
                      0xFFE74C3C,
                    ).withValues(alpha: 0.2),
                    checkmarkColor: const Color(0xFFE74C3C),
                  ),
                );
              },
            ),
          ),

          // Activity 10: Grid Layout using Row and Column in same widget tree
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildPizzaGrid(),
            ),
          ),
        ],
      ),
    );
  }

  List<MenuItem> _getMenuItems() {
    // Filter items based on selected category
    final allItems = _getAllMenuItems();
    if (selectedCategory == 'All') {
      return allItems;
    }
    return allItems.where((item) => item.category == selectedCategory).toList();
  }

  List<MenuItem> _getAllMenuItems() {
    return [
      MenuItem(
        name: 'Margherita',
        description: 'Classic tomato sauce, mozzarella, and fresh basil',
        price: 299.0,
        imagePath: 'assets/images/margherita.png',
        category: 'Classic',
        rating: 4.8,
      ),
      MenuItem(
        name: 'Pepperoni',
        description: 'Spicy pepperoni with mozzarella cheese',
        price: 399.0,
        imagePath: 'assets/images/pepperoni.png',
        category: 'Classic',
        rating: 4.9,
      ),
      MenuItem(
        name: 'BBQ Chicken',
        description: 'Grilled chicken, BBQ sauce, red onions, and cilantro',
        price: 499.0,
        imagePath: 'assets/images/bbq_chicken.png',
        category: 'Premium',
        rating: 4.7,
      ),
      MenuItem(
        name: 'Veggie Supreme',
        description: 'Bell peppers, mushrooms, onions, olives, and tomatoes',
        price: 349.0,
        imagePath: 'assets/images/veggie_supreme.png',
        category: 'Vegetarian',
        rating: 4.6,
      ),
      MenuItem(
        name: 'Spicy Jalapeño',
        description: 'Hot jalapeños, spicy sausage, and extra cheese',
        price: 449.0,
        imagePath: 'assets/images/spicy_jalapeno.png',
        category: 'Spicy',
        rating: 4.5,
      ),
      MenuItem(
        name: 'Hawaiian',
        description: 'Ham, pineapple, and mozzarella cheese',
        price: 399.0,
        imagePath: 'assets/images/hawaiian.png',
        category: 'Classic',
        rating: 4.4,
      ),
      MenuItem(
        name: 'Meat Lovers',
        description: 'Pepperoni, sausage, bacon, and ham',
        price: 549.0,
        imagePath: 'assets/images/meat_lovers.png',
        category: 'Premium',
        rating: 4.8,
      ),
      MenuItem(
        name: 'Garden Fresh',
        description: 'Spinach, artichokes, sun-dried tomatoes, and feta',
        price: 449.0,
        imagePath: 'assets/images/garden_fresh.png',
        category: 'Vegetarian',
        rating: 4.7,
      ),
    ];
  }

  void _showCustomizationDialog(BuildContext context, MenuItem item) {
    showDialog(
      context: context,
      builder: (context) => _CustomizationDialog(item: item),
    );
  }

  Widget _buildPizzaGrid() {
    final menuItems = _getMenuItems();

    if (menuItems.isEmpty) {
      return const Center(
        child: Text(
          'No pizzas found in this category',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(children: _buildGridRows(menuItems)),
    );
  }

  List<Widget> _buildGridRows(List<MenuItem> menuItems) {
    List<Widget> rows = [];

    for (int i = 0; i < menuItems.length; i += 2) {
      List<Widget> rowChildren = [];

      // First item in the row
      rowChildren.add(
        Expanded(
          child: _PizzaGridCard(
            item: menuItems[i],
            onTap: () => _showCustomizationDialog(context, menuItems[i]),
          ),
        ),
      );

      // Second item in the row (if exists)
      if (i + 1 < menuItems.length) {
        rowChildren.add(const SizedBox(width: 12));
        rowChildren.add(
          Expanded(
            child: _PizzaGridCard(
              item: menuItems[i + 1],
              onTap: () => _showCustomizationDialog(context, menuItems[i + 1]),
            ),
          ),
        );
      } else {
        // If odd number of items, add an empty expanded widget to maintain layout
        rowChildren.add(const SizedBox(width: 12));
        rowChildren.add(const Expanded(child: SizedBox()));
      }

      rows.add(Row(children: rowChildren));

      // Add spacing between rows (except for the last row)
      if (i + 2 < menuItems.length) {
        rows.add(const SizedBox(height: 12));
      }
    }

    return rows;
  }
}

class MenuItem {
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final String category;
  final double rating;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.rating,
  });
}

class _CustomizationDialog extends StatefulWidget {
  final MenuItem item;

  const _CustomizationDialog({required this.item});

  @override
  State<_CustomizationDialog> createState() => _CustomizationDialogState();
}

class _CustomizationDialogState extends State<_CustomizationDialog> {
  String selectedSize = 'Medium';
  List<String> selectedToppings = [];

  final Map<String, double> sizes = {
    'Small': 0.0,
    'Medium': 50.0,
    'Large': 100.0,
    'Extra Large': 150.0,
  };

  final List<String> availableToppings = [
    'Extra Cheese',
    'Pepperoni',
    'Mushrooms',
    'Onions',
    'Bell Peppers',
    'Olives',
    'Jalapeños',
    'Bacon',
  ];

  @override
  Widget build(BuildContext context) {
    final basePrice = widget.item.price;
    final sizePrice = sizes[selectedSize] ?? 0.0;
    final toppingPrice = selectedToppings.length * 25.0;
    final totalPrice = basePrice + sizePrice + toppingPrice;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFE74C3C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  PizzaImageWidget(
                    imagePath: widget.item.imagePath,
                    width: 50,
                    height: 50,
                    borderRadius: 8,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.item.description,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Size Selection
                    const Text(
                      'Size',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...sizes.keys.map(
                      (size) => ListTile(
                        title: Text(size),
                        subtitle: Text(
                          sizes[size]! > 0
                              ? '+₱${sizes[size]!.toStringAsFixed(0)}'
                              : 'Base price',
                        ),
                        leading: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedSize == size
                                    ? const Color(0xFFE74C3C)
                                    : Colors.grey,
                                width: 2,
                              ),
                              color: selectedSize == size
                                  ? const Color(0xFFE74C3C)
                                  : Colors.transparent,
                            ),
                            child: selectedSize == size
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  )
                                : null,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Toppings Selection
                    const Text(
                      'Extra Toppings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...availableToppings.map(
                      (topping) => CheckboxListTile(
                        title: Text(topping),
                        subtitle: const Text('+₱25'),
                        value: selectedToppings.contains(topping),
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedToppings.add(topping);
                            } else {
                              selectedToppings.remove(topping);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer with Price and Add Button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        '₱${totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE74C3C),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${widget.item.name} added to cart!'),
                          backgroundColor: const Color(0xFFE74C3C),
                        ),
                      );
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PizzaGridCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onTap;

  const _PizzaGridCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pizza Image using PizzaImageWidget
              Container(
                height: 120,
                width: double.infinity,
                child: PizzaImageWidget(
                  imagePath: item.imagePath,
                  width: double.infinity,
                  height: 120,
                  borderRadius: 12,
                ),
              ),
              const SizedBox(height: 8),

              // Pizza Name
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Description
              Text(
                item.description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Rating and Price Row
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber[600], size: 14),
                  const SizedBox(width: 2),
                  Text(
                    item.rating.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₱${item.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE74C3C),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
