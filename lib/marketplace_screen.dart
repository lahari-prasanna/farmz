import 'package:flutter/material.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  // Dummy marketplace items (later replace with real database)
  final List<Map<String, dynamic>> items = const [
    {
      'name': 'Wheat Seeds',
      'price': 200,
      'seller': 'Co-op',
      'image': 'assets/images/wheat_seeds.png'
    },
    {
      'name': 'Fertilizer X',
      'price': 500,
      'seller': 'Dealer',
      'image': 'assets/images/fertilizer.png'
    },
    {
      'name': 'Sprayer Tool',
      'price': 1500,
      'seller': 'Dealer',
      'image': 'assets/images/sprayer.png'
    },
    {
      'name': 'Pesticide Y',
      'price': 800,
      'seller': 'Co-op',
      'image': 'assets/images/pesticide.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Request Status
          const Text(
            'Request Status',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              StatusChip(label: 'Wheat - Approved', color: Colors.green),
              SizedBox(width: 8),
              StatusChip(label: 'Onions - Rejected', color: Colors.red),
            ],
          ),
          const SizedBox(height: 16),

          // Marketplace Grid
          Expanded(
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            item['image'],
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('₹${item['price']}'),
                        Text('Seller: ${item['seller']}', style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () {
                            // Buy button pressed → handle later
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Buy ${item['name']} pressed')),
                            );
                          },
                          child: const Text('Buy'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Status Chip Widget
class StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  const StatusChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
