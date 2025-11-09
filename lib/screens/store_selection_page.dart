import 'package:flutter/material.dart';
import '../widgets/base_layout.dart';
import '../constants/colors.dart';

class StoreSelectionPage extends StatefulWidget {
  final String selectedCategory;

  const StoreSelectionPage({super.key, required this.selectedCategory});

  @override
  State<StoreSelectionPage> createState() => _StoreSelectionPageState();
}

class _StoreSelectionPageState extends State<StoreSelectionPage> {
  String? _selectedStore;

  final List<String> _stores = [
    'Store 1',
    'Store 2',
    'Store 3',
    'Store 4',
    'Store 5',
  ];

  void _handleLaunch() {
    if (_selectedStore == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a store')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Launching with Category: ${widget.selectedCategory}, Store: $_selectedStore',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      animateContent: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Column(
            children: [
              Text(
                'Empowering Data-Driven Decisions',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.secondaryMain,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'with Agility',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.secondaryMain,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 5),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 20,
                color: AppColors.secondaryMain,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(text: 'Through Smart '),
                TextSpan(
                  text: 'Value',
                  style: TextStyle(
                    color: AppColors.accentMain,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: '™ Platform'),
              ],
            ),
          ),
          const SizedBox(height: 40),
          DropdownButtonFormField<String>(
            value: _selectedStore,
            decoration: InputDecoration(
              hintText: 'Select Store',
              hintStyle: TextStyle(color: AppColors.secondaryDark),
              filled: true,
              fillColor: AppColors.secondaryMain,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
            dropdownColor: AppColors.secondaryMain,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
            style: const TextStyle(color: Colors.black87, fontSize: 16),
            items: _stores.map((String store) {
              return DropdownMenuItem<String>(value: store, child: Text(store));
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedStore = newValue;
              });
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleLaunch,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryMain,
                foregroundColor: AppColors.primaryMain,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Launch',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
