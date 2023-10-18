import 'dart:async';

import 'package:busync/components/drawer.dart';
import 'package:busync/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  // Location _locationController = new Location();
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  static const LatLng sreeBuddha = LatLng(9.2125, 76.6424);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admin',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: primaryGradient,
          ),
        ),
      ),
      drawer: const DrawerIcon(),
      body: GoogleMap(
        onMapCreated: ((GoogleMapController controller) =>
            mapController.complete(controller)),
        initialCameraPosition:
            const CameraPosition(target: sreeBuddha, zoom: 15),
      ),
    );
  }
}
