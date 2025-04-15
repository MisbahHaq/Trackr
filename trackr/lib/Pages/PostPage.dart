import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropoffController = TextEditingController();
  final TextEditingController pickupNameController = TextEditingController();
  final TextEditingController dropoffNameController = TextEditingController();
  final TextEditingController pickupPhoneController = TextEditingController();
  final TextEditingController dropoffPhoneController = TextEditingController();

  double? distance;
  double? price;
  bool isLoading = false;

  final String apiKey =
      'pk.c794a602d96c919a87d22dfc7800f410'; // Replace with your key

  Future<void> calculateDistanceAndPrice() async {
    final pickup = pickupController.text;
    final dropoff = dropoffController.text;

    if (pickup.isEmpty || dropoff.isEmpty) return;

    setState(() => isLoading = true);

    try {
      final pickupCoord = await getCoordinates(pickup);
      final dropoffCoord = await getCoordinates(dropoff);

      if (pickupCoord == null || dropoffCoord == null) {
        print('Error: Unable to fetch coordinates');
        return;
      }

      final distanceInMeters = await getDistance(pickupCoord, dropoffCoord);
      final distanceInKm = distanceInMeters / 1000;
      final calculatedPrice = (distanceInKm * 20).ceilToDouble();

      setState(() {
        distance = distanceInKm;
        price = calculatedPrice;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<List<double>?> getCoordinates(String location) async {
    final url =
        'https://us1.locationiq.com/v1/search.php?key=$apiKey&q=$location&format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        return [lon, lat];
      }
    }
    return null;
  }

  Future<double> getDistance(List<double> start, List<double> end) async {
    final url =
        'https://us1.locationiq.com/v1/directions/driving/${start[0]},${start[1]};${end[0]},${end[1]}?key=$apiKey&overview=false';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final distanceMeters =
          data['routes'][0]['distance'].toDouble(); // in meters
      return distanceMeters;
    } else {
      throw Exception('Failed to get distance');
    }
  }

  Future<void> placeOrder() async {
    final pickup = pickupController.text;
    final dropoff = dropoffController.text;
    final pickupName = pickupNameController.text;
    final dropoffName = dropoffNameController.text;
    final pickupPhone = pickupPhoneController.text;
    final dropoffPhone = dropoffPhoneController.text;

    if (pickup.isEmpty ||
        dropoff.isEmpty ||
        pickupName.isEmpty ||
        dropoffName.isEmpty ||
        pickupPhone.isEmpty ||
        dropoffPhone.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    await FirebaseFirestore.instance.collection('orders').add({
      'pickup': pickup,
      'dropoff': dropoff,
      'pickupName': pickupName,
      'dropoffName': dropoffName,
      'pickupPhone': pickupPhone,
      'dropoffPhone': dropoffPhone,
      'distance': distance,
      'price': price,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Order Placed Successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6053f8),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            const Center(
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
                      const Text(
                        "Add Location",
                        style: TextStyle(fontSize: 22.0),
                      ),
                      const SizedBox(height: 20.0),

                      // Pickup Details Card
                      buildDetailsCard(
                        "Pick Up",
                        pickupController,
                        pickupNameController,
                        pickupPhoneController,
                      ),

                      const SizedBox(height: 20.0),
                      // Drop-off Details Card
                      buildDetailsCard(
                        "Drop Off",
                        dropoffController,
                        dropoffNameController,
                        dropoffPhoneController,
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: GestureDetector(
                          onTap: isLoading ? null : calculateDistanceAndPrice,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width / 1.9,
                            decoration: BoxDecoration(
                              color: const Color(0xff6053f8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child:
                                  isLoading
                                      ? const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      )
                                      : const Text(
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
                                const Text(
                                  "Total Price",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  price != null ? "₹$price" : "₹0",
                                  style: const TextStyle(fontSize: 28.0),
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
                            GestureDetector(
                              onTap: placeOrder,
                              child: Container(
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: const Color(0xff6053f8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Place Order",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
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

  Widget buildDetailsCard(
    String title,
    TextEditingController locationController,
    TextEditingController nameController,
    TextEditingController phoneController,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45, width: 2.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title Details", style: const TextStyle(fontSize: 24.0)),
          const SizedBox(height: 10.0),
          buildRow(
            Icons.location_on_rounded,
            "Enter $title Address",
            locationController,
          ),
          const SizedBox(height: 10.0),
          buildRow(Icons.person_2_rounded, "Enter User Name", nameController),
          const SizedBox(height: 10.0),
          buildRow(
            Icons.phone_android_rounded,
            "Enter Phone Number",
            phoneController,
          ),
        ],
      ),
    );
  }

  Widget buildRow(
    IconData icon,
    String hint,
    TextEditingController controller,
  ) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xff6053f8), size: 30.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
