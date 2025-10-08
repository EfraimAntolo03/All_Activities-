import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> messages = [
    ChatMessage(
      text: 'Hello! Your order #12345 has been confirmed.',
      isFromUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      messageType: MessageType.system,
    ),
    ChatMessage(
      text: 'Great! When will it be ready?',
      isFromUser: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 29)),
      messageType: MessageType.text,
    ),
    ChatMessage(
      text: 'Your pizza is being prepared and will be ready in 20 minutes.',
      isFromUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 28)),
      messageType: MessageType.text,
    ),
    ChatMessage(
      text:
          'Your order is out for delivery! Our driver will arrive in 10 minutes.',
      isFromUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      messageType: MessageType.status,
    ),
    ChatMessage(
      text: 'Perfect! I\'ll be waiting.',
      isFromUser: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      messageType: MessageType.text,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Support'),
        backgroundColor: const Color(0xFFE74C3C),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              _showCallDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Order Info Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE74C3C).withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE74C3C),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PizzaHot Support',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Order #12345 • Preparing',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Activity 9: Chat bubble UI using Container with padding, margin, and rounded borders
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _ChatBubble(message: message);
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE74C3C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(
          ChatMessage(
            text: _messageController.text.trim(),
            isFromUser: true,
            timestamp: DateTime.now(),
            messageType: MessageType.text,
          ),
        );
      });
      _messageController.clear();
    }
  }

  void _showCallDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Support'),
        content: const Text('Call PizzaHot support at +63 912 345 6789'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Calling support...'),
                  backgroundColor: Color(0xFFE74C3C),
                ),
              );
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isFromUser;
  final DateTime timestamp;
  final MessageType messageType;

  ChatMessage({
    required this.text,
    required this.isFromUser,
    required this.timestamp,
    required this.messageType,
  });
}

enum MessageType { text, system, status }

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isFromUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isFromUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE74C3C),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.support_agent,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _getBubbleColor(),
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomLeft: message.isFromUser
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: message.isFromUser
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.messageType == MessageType.status) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.local_pizza,
                          color: Colors.orange[600],
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Order Update',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.orange[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(
                    message.text,
                    style: TextStyle(color: _getTextColor(), fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(color: _getTimeColor(), fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          if (message.isFromUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  Color _getBubbleColor() {
    if (message.messageType == MessageType.system) {
      return Colors.blue[100]!;
    } else if (message.messageType == MessageType.status) {
      return Colors.orange[100]!;
    } else if (message.isFromUser) {
      return const Color(0xFFE74C3C);
    } else {
      return Colors.grey[200]!;
    }
  }

  Color _getTextColor() {
    if (message.messageType == MessageType.system) {
      return Colors.blue[800]!;
    } else if (message.messageType == MessageType.status) {
      return Colors.orange[800]!;
    } else if (message.isFromUser) {
      return Colors.white;
    } else {
      return Colors.black87;
    }
  }

  Color _getTimeColor() {
    if (message.isFromUser) {
      return Colors.white70;
    } else {
      return Colors.grey[600]!;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
