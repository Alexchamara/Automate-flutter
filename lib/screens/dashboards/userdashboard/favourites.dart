import 'package:automate/controllers/listing_controller.dart';
import 'package:automate/models/listing.dart';
import 'package:flutter/material.dart';
import '../../../components/dashboard/favouriteCard.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late Future<List<Listing>> _favoriteListings;

  @override
  void initState() {
    super.initState();
    _favoriteListings = ListingController.getFavoriteListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Listing>>(
        future: _favoriteListings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: emptyFavourite());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return favouriteCard(listing: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
//create empty favourite card with description, large icon and button to search adverts
Widget emptyFavourite() {
  return Card(
    child: Column(
      children: <Widget>[
        const Center(
          child: ListTile(
            title: Text('No Favourites',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            subtitle: Text('You have no favourites yet',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal)),
          ),
        ),
        const Icon(
          Icons.favorite,
          size: 100.0,
          color: Colors.red,
        ),
        ElevatedButton(
          onPressed: () {
            // Navigate to the search adverts page
          },
          child: const Text('Search Adverts'),
        ),
      ],
    ),
  );
}
