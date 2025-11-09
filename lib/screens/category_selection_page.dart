import 'package:flutter/material.dart';
import '../widgets/base_layout.dart';
import '../constants/colors.dart';
import 'store_selection_page.dart';
import 'transition_screen.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage> {
  String? _selectedCategory;

  final List<String> _categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
  ];

  void _handleNext() {
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransitionScreen(
          nextPage: StoreSelectionPage(selectedCategory: _selectedCategory!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
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
            value: _selectedCategory,
            decoration: InputDecoration(
              hintText: 'Select Category',
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
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleNext,
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
                'Next',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
