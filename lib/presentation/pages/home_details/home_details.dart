import '../../../domain/entities/beers.dart';
import 'package:flutter/material.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beers = ModalRoute.of(context)?.settings.arguments as Beers;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beer Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.bottomCenter, child: Image.network(beers.imageUrl!, width: width / 2, height: height / 3)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 90,
                    child: Text(
                      "Name: " + beers.name! + ",",
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.red),
                    ),
                  ),
                  Flexible(
                    flex: 20,
                    child: Text(
                      "ABV:" + beers.abv.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "food pairings:".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                beers.foodPairing!.join(". \n"),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Description:".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                beers.description!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
