import 'package:flutter/material.dart';
import 'package:shoprite/components/button.dart';
import 'package:shoprite/components/default_scaffold.dart';
import 'package:shoprite/components/input_field.dart';
import 'package:shoprite/constants/colors.dart';
import 'package:shoprite/external/api_client.dart';
import 'package:shoprite/external/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = "";
  final List _products = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        body: Center(
      child: Column(
        children: [
          InputField(
            hintText: "Search for products",
            actionIcon: _isLoading ? Icons.access_time : Icons.search,
            onAction: _isLoading
                ? null
                : () async {
                    if (_searchQuery.isEmpty) {
                      return;
                    }
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final value = await APIClient().fetchSearch(params: {"q": _searchQuery});
                      if (value != null) {
                        setState(() {
                          _products.clear();
                          value["products"].forEach((product) {
                            _products.add(product);
                          });
                        });
                      } else {
                        print("Error fetching data");
                      }
                    } catch (e) {
                      print("Error: $e");
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _isLoading
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Loading products...", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: _products.isEmpty
                      ? const Center(
                          child: Text("No products found"),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            var currentProduct = _products[index];
                            return ExpansionTile(
                              showTrailingIcon: false,
                              collapsedBackgroundColor: Colors.white,
                              backgroundColor: Colors.white,
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text(currentProduct["productName"]),
                              subtitle: Text(
                                  "${Utils.formatPrice(currentProduct["currentPrice"])} -  ${currentProduct["vendor"]}"),
                              leading: currentProduct["vendor"] != null
                                  ? Image.network(
                                      currentProduct["vendor"] == "Flipkart"
                                          ? "https://static-assets-web.flixcart.com/batman-returns/batman-returns/p/images/logo_lite-cbb357.png"
                                          : currentProduct["vendor"] == "Amazon"
                                              ? "https://upload.wikimedia.org/wikipedia/commons/d/de/Amazon_icon.png"
                                              : "https://via.placeholder.com/30",
                                      height: 30,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.store);
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const CircularProgressIndicator();
                                      },
                                    )
                                  : const Icon(Icons.store),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          currentProduct["thumbnail"],
                                          errorBuilder: (context, error, stackTrace) {
                                            return SizedBox(height: 100, width: 100, child: Icon(Icons.error));
                                          },
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                                height: 100,
                                                width: 100,
                                                decoration: const BoxDecoration(color: Colors.grey));
                                          },
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              Utils.formatPrice(currentProduct["currentPrice"]),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Text(
                                              Utils.formatPrice(currentProduct["originalPrice"]),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: kTextColor,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                            Text("Vendor: ${currentProduct["vendor"]}"),
                                            const SizedBox(height: 10),
                                            Button(
                                                text: "Buy now",
                                                onPressed: () {
                                                  launchUrl(
                                                    Uri.parse(currentProduct["productLink"]),
                                                    mode: LaunchMode.externalApplication,
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
        ],
      ),
    ));
  }
}
