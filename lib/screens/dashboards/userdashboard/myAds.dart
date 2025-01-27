import 'package:automate/screens/advertForm.dart';
import 'package:flutter/material.dart';
import '../../../components/dashboard/advertCard.dart';
import '../../../controllers/listing_controller.dart';
import '../../../models/listing.dart';

class MyAdsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Ads',
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
        future: ListingController.getUserListings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search, size: 80, color: Color(0xFF6C757D)),
                  const Text(
                    'No adverts found',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C757D),
                    ),
                  ),
                  const Text(
                    "We couldn't find any records. Try changing search filters",
                    style: TextStyle(color: Color(0xFF6C757D)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CreateAdvertForm.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text('Create a new advert',
                       style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return AdvertCard(
                    listing: snapshot.data![index],
                    advert: snapshot.data![index].advert
                );
              },
            );
          }
        },
      ),
    );
  }
}
