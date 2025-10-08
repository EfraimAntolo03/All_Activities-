import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String selectedTab = 'Active';

  final List<Order> orders = [
    Order(
      id: '#12345',
      status: 'Preparing',
      items: ['Margherita (Medium)', 'Pepperoni (Large)'],
      total: 848.0,
      orderTime: DateTime.now().subtract(const Duration(minutes: 15)),
      estimatedDelivery: DateTime.now().add(const Duration(minutes: 25)),
    ),
    Order(
      id: '#12344',
      status: 'Delivered',
      items: ['BBQ Chicken (Medium)'],
      total: 549.0,
      orderTime: DateTime.now().subtract(const Duration(hours: 2)),
      estimatedDelivery: DateTime.now().subtract(
        const Duration(hours: 1, minutes: 30),
      ),
    ),
    Order(
      id: '#12343',
      status: 'Delivered',
      items: ['Veggie Supreme (Large)', 'Hawaiian (Medium)'],
      total: 898.0,
      orderTime: DateTime.now().subtract(const Duration(days: 1)),
      estimatedDelivery: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeOrders = orders
        .where((order) => order.status != 'Delivered')
        .toList();
    final pastOrders = orders
        .where((order) => order.status == 'Delivered')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Orders refreshed'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _TabButton(
                    label: 'Active (${activeOrders.length})',
                    isSelected: selectedTab == 'Active',
                    onTap: () => setState(() => selectedTab = 'Active'),
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    label: 'Past (${pastOrders.length})',
                    isSelected: selectedTab == 'Past',
                    onTap: () => setState(() => selectedTab = 'Past'),
                  ),
                ),
              ],
            ),
          ),

          // Activity 8: Orders List with Flexible for dynamic resizing
          Flexible(
            flex: 3,
            child: selectedTab == 'Active'
                ? _buildOrdersList(activeOrders)
                : _buildOrdersList(pastOrders),
          ),

          // Order Summary with Flexible for dynamic resizing
          Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE74C3C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE74C3C).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Orders: ${orders.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '₱${orders.fold(0.0, (sum, order) => sum + order.total).toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFFE74C3C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active: ${activeOrders.length}',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      Text(
                        'Delivered: ${pastOrders.length}',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedTab == 'Active' ? '📦' : '📋',
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 24),
            Text(
              selectedTab == 'Active' ? 'No active orders' : 'No past orders',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              selectedTab == 'Active'
                  ? 'Your active orders will appear here'
                  : 'Your order history will appear here',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/menu');
              },
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Order Now'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderCard(
          order: order,
          onTrack: () => _showTrackingDialog(context, order),
          onReorder: selectedTab == 'Past' ? () => _reorderItems(order) : null,
        );
      },
    );
  }

  void _showTrackingDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order ${order.id}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TrackingStep(
              title: 'Order Placed',
              isCompleted: true,
              time: order.orderTime,
            ),
            _TrackingStep(
              title: 'Preparing',
              isCompleted:
                  order.status == 'Preparing' ||
                  order.status == 'Out for Delivery' ||
                  order.status == 'Delivered',
              isCurrent: order.status == 'Preparing',
              time: order.orderTime.add(const Duration(minutes: 5)),
            ),
            _TrackingStep(
              title: 'Out for Delivery',
              isCompleted:
                  order.status == 'Out for Delivery' ||
                  order.status == 'Delivered',
              isCurrent: order.status == 'Out for Delivery',
              time: order.estimatedDelivery.subtract(
                const Duration(minutes: 15),
              ),
            ),
            _TrackingStep(
              title: 'Delivered',
              isCompleted: order.status == 'Delivered',
              isCurrent: order.status == 'Delivered',
              time: order.estimatedDelivery,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _reorderItems(Order order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${order.items.length} items added to cart'),
        backgroundColor: const Color(0xFFE74C3C),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }
}

class Order {
  final String id;
  final String status;
  final List<String> items;
  final double total;
  final DateTime orderTime;
  final DateTime estimatedDelivery;

  Order({
    required this.id,
    required this.status,
    required this.items,
    required this.total,
    required this.orderTime,
    required this.estimatedDelivery,
  });
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE74C3C) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTrack;
  final VoidCallback? onReorder;

  const _OrderCard({
    required this.order,
    required this.onTrack,
    this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.id,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: _getStatusColor(order.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Items
            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $item',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Total and Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₱${order.total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE74C3C),
                  ),
                ),
                Text(
                  _formatOrderTime(order.orderTime),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onTrack,
                    icon: const Icon(Icons.track_changes, size: 18),
                    label: const Text('Track Order'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE74C3C),
                      side: const BorderSide(color: Color(0xFFE74C3C)),
                    ),
                  ),
                ),
                if (onReorder != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onReorder,
                      icon: const Icon(Icons.replay, size: 18),
                      label: const Text('Reorder'),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Preparing':
        return Colors.orange;
      case 'Out for Delivery':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatOrderTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}

class _TrackingStep extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final bool isCurrent;
  final DateTime time;

  const _TrackingStep({
    required this.title,
    required this.isCompleted,
    this.isCurrent = false,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted
                  ? const Color(0xFFE74C3C)
                  : isCurrent
                  ? const Color(0xFFE74C3C).withValues(alpha: 0.3)
                  : Colors.grey[300],
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 12)
                : isCurrent
                ? Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE74C3C),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted || isCurrent
                        ? Colors.black
                        : Colors.grey[600],
                  ),
                ),
                Text(
                  _formatTime(time),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
