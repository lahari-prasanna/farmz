// lib/home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dynamic crop health (1..10), can replace with real data
  int cropHealth = 7;

  // Dummy alerts (replace with Firestore data later)
  final List<Map<String, dynamic>> alerts = [
    {'text': 'New Pest is detected by TrapZ (High risk)', 'color': Colors.red, 'border': Colors.redAccent},
    {'text': 'Wheat - Approved (live on market)', 'color': Colors.green, 'border': Colors.greenAccent},
    {'text': 'Your current crop price is ₹100/kg in Kodangal', 'color': Colors.green, 'border': Colors.greenAccent},
  ];

  // Dummy weather cards
  final List<Map<String, String>> weatherItems = [
    {'title': 'Today', 'temp': '28°C', 'cond': 'Sunny', 'loc': 'Kodangal'},
    {'title': 'Tomorrow', 'temp': '26°C', 'cond': 'Cloudy', 'loc': 'Kodangal'},
  ];

  void _onSyncLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location synced (demo)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),

          // ---------- Weather & Spraying horizontal scroll ----------
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: weatherItems.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                if (index < weatherItems.length) {
                  final w = weatherItems[index];
                  return WeatherCard(
                    title: w['title']!,
                    temp: w['temp']!,
                    cond: w['cond']!,
                    location: w['loc']!,
                  );
                } else {
                  return const SprayingConditionCard(
                    condition: 'Moderate',
                    advice: 'Good for neem oil; avoid before rain.',
                  );
                }
              },
            ),
          ),

          const SizedBox(height: 16),

          // ---------- Location Row ----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.green),
                  SizedBox(width: 6),
                  Text(
                    'Location: Kodangal (synced)',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: _onSyncLocation,
                icon: const Icon(Icons.sync),
                label: const Text('Sync'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ---------- Crop Health ----------
          const Text('Crop Health', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              CropHealthMeter(rating: cropHealth),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rating: $cropHealth / 10', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Last updated: Today 09:30 AM'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Adjust:'),
                        Expanded(
                          child: Slider(
                            min: 1,
                            max: 10,
                            divisions: 9,
                            value: cropHealth.toDouble(),
                            onChanged: (v) => setState(() => cropHealth = v.toInt()),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ---------- Alerts Section ----------
          const Text('Alerts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Column(
            children: alerts
                .map(
                  (a) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AlertTile(text: a['text'], color: a['color'], borderColor: a['border']),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ---------------- Weather Card ----------------
class WeatherCard extends StatelessWidget {
  final String title, temp, cond, location;
  const WeatherCard({super.key, required this.title, required this.temp, required this.cond, required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(temp, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(cond),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.wb_sunny, size: 40, color: Colors.orange),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Text(location, style: const TextStyle(fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- Spraying Condition Card ----------------
class SprayingConditionCard extends StatelessWidget {
  final String condition;
  final String advice;
  const SprayingConditionCard({super.key, required this.condition, required this.advice});

  Color _colorFor(String c) {
    final s = c.toLowerCase();
    if (s.contains('low')) return Colors.green;
    if (s.contains('moderate')) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(condition);
    return Card(
      color: color.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: color, width: 1)),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spraying Condition', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(condition, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(advice, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ---------------- Crop Health Meter ----------------
class CropHealthMeter extends StatelessWidget {
  final int rating;
  const CropHealthMeter({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final percent = (rating.clamp(1, 10)) / 10;
    final color = percent > 0.7 ? Colors.green : (percent > 0.4 ? Colors.orange : Colors.red);

    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(alignment: Alignment.center, children: [
        SizedBox(
          width: 110,
          height: 110,
          child: CircularProgressIndicator(
            value: percent,
            strokeWidth: 10,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text('$rating / 10', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(percent >= 0.7 ? 'Good' : (percent >= 0.4 ? 'Moderate' : 'Poor'), style: TextStyle(color: color)),
        ])
      ]),
    );
  }
}

// ---------------- Alert Tile ----------------
class AlertTile extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;
  const AlertTile({super.key, required this.text, required this.color, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(side: BorderSide(color: borderColor, width: 1), borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: CircleAvatar(radius: 12, backgroundColor: color),
        title: Text(text),
      ),
    );
  }
}
