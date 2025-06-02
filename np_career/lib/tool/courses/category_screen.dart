import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';
import 'package:provider/provider.dart';
import 'package:np_career/model/category.dart';
import 'package:np_career/tool/courses/providers/CategoryProvider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Categories"),
        centerTitle: true,
        backgroundColor: AppColor.orangePrimaryColor,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: provider.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 3 / 1.5,
                ),
                itemBuilder: (context, index) {
                  final category = provider.categories[index];
                  return CategoryCard(category: category);
                },
              ),
            ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final MyCategory category;
  const CategoryCard({super.key, required this.category});

  void _showDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(category.name),
        content: Text(category.description ?? "No description"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.greenPrimaryColor.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.category,
            color: AppColor.greenPrimaryColor,
            size: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              category.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () => _showDescriptionDialog(context),
            child: const Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
