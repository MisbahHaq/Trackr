import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DistancePriceCalculator extends StatefulWidget {
  @override
  _DistancePriceCalculatorState createState() =>
      _DistancePriceCalculatorState();
}

class _DistancePriceCalculatorState extends State<DistancePriceCalculator> {
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropoffController = TextEditingController();
  double? distanceKm;
  double? price;

  Future<void> getDistanceAndPrice() async {
    String pickup = pickupController.text;
    String dropoff = dropoffController.text;

    if (pickup.isEmpty || dropoff.isEmpty) return;

    try {
      // Geocode pickup
      var pickupRes = await http.get(
        Uri.parse(
          'https://api.openrouteservice.org/geocode/search?api_key=${dotenv.env['ORS_API_KEY']}&text=$pickup',
        ),
      );
      var pickupJson = jsonDecode(pickupRes.body);
      var pickupCoords = pickupJson['features'][0]['geometry']['coordinates'];

      // Geocode dropoff
      var dropoffRes = await http.get(
        Uri.parse(
          'https://api.openrouteservice.org/geocode/search?api_key=${dotenv.env['ORS_API_KEY']}&text=$dropoff',
        ),
      );
      var dropoffJson = jsonDecode(dropoffRes.body);
      var dropoffCoords = dropoffJson['features'][0]['geometry']['coordinates'];

      // Get distance
      var distanceRes = await http.post(
        Uri.parse('https://api.openrouteservice.org/v2/matrix/driving-car'),
        headers: {
          'Authorization': dotenv.env['ORS_API_KEY']!,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "locations": [pickupCoords, dropoffCoords],
          "metrics": ["distance"],
        }),
      );

      var distanceJson = jsonDecode(distanceRes.body);
      double meters = distanceJson['distances'][0][1];
      double km = meters / 1000;

      setState(() {
        distanceKm = km;
        price = km * 20; // your pricing logic (e.g. Rs. 20 per KM)
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        distanceKm = null;
        price = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delivery Price Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: pickupController,
              decoration: InputDecoration(labelText: "Enter Pickup Location"),
            ),
            TextField(
              controller: dropoffController,
              decoration: InputDecoration(labelText: "Enter Dropoff Location"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getDistanceAndPrice,
              child: Text("Calculate Distance and Price"),
            ),
            SizedBox(height: 30),
            if (distanceKm != null && price != null)
              Column(
                children: [
                  Text(
                    "Distance: ${distanceKm!.toStringAsFixed(2)} km",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Price: Rs. ${price!.toStringAsFixed(0)}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
