import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';

import '../../domain/model/pharmacy.dart';
import '../../domain/model/pharmacy_details.dart';
import '../widget/information_row.dart';
import '../widget/pharmacy_details_widget.dart';
import 'pharmacy_details_view_model.dart';

class PharmacyDetailsScreen extends StatefulWidget {
  const PharmacyDetailsScreen({Key? key, required this.pharmacy}) : super(key: key);

  final Pharmacy pharmacy;

  @override
  State<PharmacyDetailsScreen> createState() => _PharmacyDetailsState();
}

class _PharmacyDetailsState extends State<PharmacyDetailsScreen> {
  final PharmacyDetailsViewModel _viewModel = PharmacyDetailsViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.getPharmacyDetails(widget.pharmacy.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pharmacy Details"),
      ),
      body: Center(
        child: ChangeNotifierProvider<PharmacyDetailsViewModel>(
          create: (context) => _viewModel,
          child: Consumer<PharmacyDetailsViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.isLoading) {
                return const CircularProgressIndicator();
              } else if (viewModel.error == null) {
                return _getPharmacyDetailsView(viewModel.pharmacyDetails!);
              } else {
                return Text('${viewModel.error}');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getPharmacyDetailsView(PharmacyDetails pharmacyDetails) {
    List<String> medications = widget.pharmacy.medications ?? [];

    if (medications.isEmpty) {
      return Column(
        children: [
          PharmacyDetailsWidget(pharmacyDetails: pharmacyDetails),
        ],
      );
    } else {
      return Column(
        children: [
          PharmacyDetailsWidget(pharmacyDetails: pharmacyDetails),
          const InformationRow(title: "Medications", value: ""),
          Expanded(
            child: SingleChildScrollView(
              child: Tags(
                itemCount: medications.length,
                runSpacing: 6,
                itemBuilder: (int index) {
                  return ItemTags(
                    index: index,
                    title: medications[index],
                    active: true,
                    pressEnabled: false,
                  );
                },
              ),
            ),
          ),
        ],
      );
    }
  }
}
