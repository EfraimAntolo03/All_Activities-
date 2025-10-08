import 'package:flutter/material.dart';
import '../widgets/pizza_image_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      name: 'Margherita',
      size: 'Medium',
      toppings: ['Extra Cheese', 'Mushrooms'],
      price: 349.0,
      quantity: 1,
      imagePath: 'assets/images/margherita.png',
    ),
    CartItem(
      name: 'Pepperoni',
      size: 'Large',
      toppings: ['Extra Cheese'],
      price: 499.0,
      quantity: 2,
      imagePath: 'assets/images/pepperoni.png',
    ),
    CartItem(
      name: 'BBQ Chicken',
      size: 'Medium',
      toppings: ['Bacon', 'Onions'],
      price: 549.0,
      quantity: 1,
      imagePath: 'assets/images/bbq_chicken.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final subtotal = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final deliveryFee = 50.0;
    final tax = subtotal * 0.08;
    final total = subtotal + deliveryFee + tax;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              _showClearCartDialog();
            },
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return _CartItemCard(
                        item: item,
                        onQuantityChanged: (newQuantity) {
                          setState(() {
                            if (newQuantity <= 0) {
                              cartItems.removeAt(index);
                            } else {
                              item.quantity = newQuantity;
                            }
                          });
                        },
                        onRemove: () {
                          setState(() {
                            cartItems.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
                _buildOrderSummary(subtotal, deliveryFee, tax, total),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🛒', style: const TextStyle(fontSize: 80)),
          const SizedBox(height: 24),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some delicious pizzas to get started!',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          // Activity 2: Two buttons in a Column, centered vertically and horizontally
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/menu');
                  },
                  icon: const Icon(Icons.restaurant_menu),
                  label: const Text('Browse Menu'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/orders');
                  },
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('View Orders'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFFE74C3C)),
                    foregroundColor: const Color(0xFFE74C3C),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(
    double subtotal,
    double deliveryFee,
    double tax,
    double total,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          _SummaryRow(label: 'Subtotal', amount: subtotal),
          _SummaryRow(label: 'Delivery Fee', amount: deliveryFee),
          _SummaryRow(label: 'Tax', amount: tax),
          const Divider(),
          _SummaryRow(label: 'Total', amount: total, isTotal: true),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showCheckoutDialog();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text(
          'Are you sure you want to remove all items from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                cartItems.clear();
              });
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Checkout'),
        content: const Text(
          'This is a UI demo. In a real app, this would process your payment and place the order.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                cartItems.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order placed successfully!'),
                  backgroundColor: Color(0xFF27AE60),
                ),
              );
            },
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final String size;
  final List<String> toppings;
  final double price;
  int quantity;
  final String imagePath;

  CartItem({
    required this.name,
    required this.size,
    required this.toppings,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Pizza Image
                PizzaImageWidget(
                  imagePath: item.imagePath,
                  width: 70,
                  height: 70,
                  borderRadius: 10,
                ),
                const SizedBox(width: 12),

                // Pizza Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Size: ${item.size}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      if (item.toppings.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Toppings: ${item.toppings.join(', ')}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // Remove Button
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red[400],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Quantity and Price
            Row(
              children: [
                // Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: item.quantity > 1
                            ? () => onQuantityChanged(item.quantity - 1)
                            : null,
                        icon: const Icon(Icons.remove),
                        iconSize: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => onQuantityChanged(item.quantity + 1),
                        icon: const Icon(Icons.add),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Price
                Text(
                  '₱${(item.price * item.quantity).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE74C3C),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.amount,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '₱${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? const Color(0xFFE74C3C) : null,
            ),
          ),
        ],
      ),
    );
  }
}
