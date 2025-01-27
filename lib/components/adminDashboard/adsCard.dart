import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../models/listing.dart';
import '../../models/advert.dart';
import '../../models/user.dart';
import 'advertDetails.dart';

class AdvertCard extends StatefulWidget {
  final Listing listing;
  final Advert advert;
  final User user;

  const AdvertCard(
      {required this.listing,
      Key? key,
      required this.advert,
      required this.user})
      : super(key: key);

  @override
  State<AdvertCard> createState() => _AdvertCardState();
}

class _AdvertCardState extends State<AdvertCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/default.jpg.webp',
                  fit: BoxFit.cover, width: double.infinity, height: 200),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.advert.brand,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 5.0),
                    Text('Price: ${widget.advert.price}',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 5.0),
                    Text('Location: ${widget.advert.location}',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 5.0),
                    Text('Status: ${widget.listing.status}',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('View Advert'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdvertDetails(
                                  listing: widget.listing,
                                  advert: widget.advert,
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                          child: const Text('Manage Advert'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                Color statusColor;
                switch (widget.listing.status) {
                  case 'approved':
                    statusColor = Colors.green;
                    break;
                  case 'rejected':
                    statusColor = Colors.red;
                    break;
                  case 'pendding':
                    statusColor = Colors.yellow;
                    break;
                  default:
                    statusColor = Colors.grey;
                }
                return Opacity(
                  opacity: _animation.value,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
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
