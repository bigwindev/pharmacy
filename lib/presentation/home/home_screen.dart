import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/model/pharmacy.dart';
import '../order/order_screen.dart';
import '../pharmacy_details/pharmacy_details_screen.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  void initState() {
    super.initState();
    _viewModel.getPharmacies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => _viewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, viewModel, _) {
              if (viewModel.isLoading) {
                return const CircularProgressIndicator();
              } else if (viewModel.error == null) {
                return _getPharmaciesListView(viewModel.pharmacies);
              } else {
                return Text('${viewModel.error}');
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const OrderScreen())
          ).then((value) => value == true ? _viewModel.getPharmacies() : null);
        },
        tooltip: 'Order',
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _getPharmaciesListView(List<Pharmacy> pharmacies) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        return ListTile(
          title: Text(
            pharmacies[index].name,
            style: _biggerFont,
          ),
          trailing: pharmacies[index].medications == null ? null : const Icon(
              Icons.check),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    PharmacyDetailsScreen(
                      pharmacy: pharmacies[index],
                    )
                )
            );
          },
        );
      },
      itemCount: pharmacies.length * 2,
    );
  }
}
