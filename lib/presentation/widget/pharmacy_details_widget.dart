import 'package:flutter/material.dart';

import '../../domain/model/pharmacy_details.dart';
import 'information_row.dart';

class PharmacyDetailsWidget extends StatelessWidget {
  const PharmacyDetailsWidget({Key? key, required this.pharmacyDetails})
      : super(key: key);

  final PharmacyDetails pharmacyDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationRow(
          title: "Name",
          value: pharmacyDetails.name,
        ),
        InformationRow(
            title: "Address",
            value: pharmacyDetails.address.getFullAddress()
        ),
        InformationRow(
          title: "Primary Phone Number",
          value: pharmacyDetails.primaryPhoneNumber ?? "-",
        ),
        InformationRow(
          title: "Pharmacy Hours",
          value: (pharmacyDetails.pharmacyHours ?? "-").replaceAll("\\n", "\n"),
        ),
      ],
    );
  }
}
