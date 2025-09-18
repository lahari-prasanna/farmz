// lib/sell_farm_produce_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SellFarmProduceScreen extends StatefulWidget {
  const SellFarmProduceScreen({super.key});

  @override
  State<SellFarmProduceScreen> createState() => _SellFarmProduceScreenState();
}

class _SellFarmProduceScreenState extends State<SellFarmProduceScreen> {
  final _formKey = GlobalKey<FormState>();

  File? _pickedImage;
  final picker = ImagePicker();

  String? _cropName;
  String? _quantity;
  String? _price;
  DateTime? _harvestDate;

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () async {
              Navigator.pop(context);
              final picked = await picker.pickImage(source: ImageSource.camera);
              if (picked != null) {
                setState(() => _pickedImage = File(picked.path));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () async {
              Navigator.pop(context);
              final picked = await picker.pickImage(source: ImageSource.gallery);
              if (picked != null) {
                setState(() => _pickedImage = File(picked.path));
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (selected != null) setState(() => _harvestDate = selected);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Form Submitted'),
          content: Text(
            'Crop: $_cropName\nQuantity: $_quantity\nPrice: $_price\nHarvest Date: ${_harvestDate != null ? DateFormat('yyyy-MM-dd').format(_harvestDate!) : ''}\nImage selected: ${_pickedImage != null}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Your Farm Produce'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: _pickedImage != null
                      ? Image.file(_pickedImage!, height: 150, width: 150, fit: BoxFit.cover)
                      : Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey[300],
                          child: const Icon(Icons.add_a_photo, size: 50),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Crop Name',
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => _cropName = val,
                validator: (val) => val == null || val.isEmpty ? 'Enter crop name' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity (kg/tons)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (val) => _quantity = val,
                validator: (val) => val == null || val.isEmpty ? 'Enter quantity' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price per unit (optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (val) => _price = val,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Text(_harvestDate != null
                        ? 'Harvest Date: ${DateFormat('yyyy-MM-dd').format(_harvestDate!)}'
                        : 'Select Harvest Date'),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text('Pick Date'),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
