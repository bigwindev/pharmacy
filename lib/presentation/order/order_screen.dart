import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';

import '../../domain/model/pharmacy_details.dart';
import '../widget/information_row.dart';
import '../widget/pharmacy_details_widget.dart';
import 'order_view_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderState();
}

class _OrderState extends State<OrderScreen> {
  final OrderViewModel _viewModel = OrderViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.getAvailablePharmacyToOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Order"),
          actions: [
            ChangeNotifierProvider<OrderViewModel>.value(
              value: _viewModel,
              child: Consumer<OrderViewModel>(
                builder: (context, viewModel, _) {
                  if (viewModel.isLoading || viewModel.error != null ||
                      viewModel.pharmacyDetails == null) {
                    return const SizedBox.shrink();
                  } else {
                    return TextButton(
                      onPressed: () => completeOrder(),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ]
      ),
      body: Center(
        child: ChangeNotifierProvider<OrderViewModel>(
          create: (context) => _viewModel,
          child: Consumer<OrderViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.isLoading) {
                return const CircularProgressIndicator();
              } else if (viewModel.error == null &&
                  viewModel.pharmacyDetails != null) {
                return _getPharmacyDetailsView(
                    viewModel.pharmacyDetails!, viewModel.medications);
              } else if (viewModel.error == null) {
                return const Text('No available pharmacy');
              } else {
                return Text('${viewModel.error}');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getPharmacyDetailsView(PharmacyDetails pharmacyDetails,
      List<String> medications) {
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
                  active: false,
                  onPressed: (item) =>
                      _viewModel.setSelected(item.title, item.active),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void completeOrder() {
    List result = _viewModel.completeOrder();
    if (result[0] == true) {
      Navigator.pop(context, true);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              result[1],
              style: const TextStyle(fontSize: 14),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
