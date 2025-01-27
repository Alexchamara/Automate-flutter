import 'package:flutter/material.dart';
import '../../../controllers/admin_controller.dart';
import '../../../models/listing.dart';
import '../../../components/adminDashboard/adsCard.dart';

class ManageAdverts extends StatelessWidget {
  const ManageAdverts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Advertisements',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Listing>>(
        future: AdminController.getAllListings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No adverts found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return AdvertCard(
                    listing: snapshot.data![index],
                    advert: snapshot.data![index].advert,
                    user: snapshot.data![index].user
                );
              },
            );
          }
        },
      ),
    );
  }
}