import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  static final String id = 'ProductDetailPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
                Icons.share,
                color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
                Icons.star_border_outlined,
                color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('Details of the product'),
      ),
    );
  }
}
