import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropoffController = TextEditingController();

  double? distance;
  double? price;

  Future<void> calculateDistanceAndPrice() async {
    final pickup = pickupController.text;
    final dropoff = dropoffController.text;

    if (pickup.isEmpty || dropoff.isEmpty) return;

    try {
      final pickupCoord = await getCoordinates(pickup);
      final dropoffCoord = await getCoordinates(dropoff);

      if (pickupCoord == null || dropoffCoord == null) {
        print('Error: Unable to fetch coordinates');
        return;
      }

      print('Pickup Coordinates: $pickupCoord');
      print('Dropoff Coordinates: $dropoffCoord');

      final distanceInMeters = await getDistance(pickupCoord, dropoffCoord);
      final distanceInKm = distanceInMeters / 1000;
      final calculatedPrice = (distanceInKm * 20).ceilToDouble(); // ₹20 per km

      setState(() {
        distance = distanceInKm;
        price = calculatedPrice;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<double>?> getCoordinates(String location) async {
    final apiKey = 'AIzaSyBj33amCtO65Hl1a2wnbw_y25IY-Rodl7s';
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$location&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    print('API Response: ${response.body}'); // Debugging response

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];
      if (results != null && results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        return [location['lng'], location['lat']];
      }
    } else {
      print('Failed to fetch coordinates for $location');
    }
    return null;
  }

  Future<double> getDistance(List<double> start, List<double> end) async {
    final apiKey = 'AIzaSyBj33amCtO65Hl1a2wnbw_y25IY-Rodl7s';
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${start[1]},${start[0]}&destinations=${end[1]},${end[0]}&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    print('Distance API Response: ${response.body}'); // Debugging response

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rows = data['rows'];
      if (rows != null && rows.isNotEmpty) {
        final elements = rows[0]['elements'];
        if (elements != null && elements.isNotEmpty) {
          return elements[0]['distance']['value']
              .toDouble(); // Distance in meters
        }
      }
    }
    throw Exception('Failed to get distance');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6053f8),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Add Package",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      Center(
                        child: Image.asset(
                          "images/delivery-truck.png",
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text("Add Location", style: TextStyle(fontSize: 22.0)),
                      const SizedBox(height: 20.0),
                      Text("Pick Up", style: TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        margin: const EdgeInsets.only(right: 20.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: pickupController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Pickup Location",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text("Drop Off", style: TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        margin: const EdgeInsets.only(right: 20.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: dropoffController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Dropoff Location",
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: GestureDetector(
                          onTap: calculateDistanceAndPrice,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 1.9,
                            decoration: BoxDecoration(
                              color: const Color(0xff6053f8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Submit Location",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        margin: const EdgeInsets.only(right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 2.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Price",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  price != null ? "₹$price" : "₹0",
                                  style: TextStyle(fontSize: 28.0),
                                ),
                                if (distance != null)
                                  Text(
                                    "${distance!.toStringAsFixed(2)} km",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 50.0),
                            Container(
                              height: 60,
                              width: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xff6053f8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Place Order",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
