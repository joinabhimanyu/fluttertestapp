import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/models/product_model.dart';
import 'package:fluttertestapp/services/product_service.dart';
import 'package:fluttertestapp/widgets/drawer_widget.dart';
import 'package:fluttertestapp/widgets/image_viewer.dart';
import 'package:fluttertestapp/widgets/share_icons.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String routeName = "ProductsPage";

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<ProductModel> _products = [];
  bool isLoading = false;
  bool isError = false;
  String error = "";
  List<int> _selectedIds = [];

  @override
  void initState() {
    super.initState();
    _fetchProductsData();
  }

  Future<void> _fetchProductsData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      var response = await fetchProducts();
      if (response.products.length > 0) {
        setState(() {
          isLoading = false;
          _products = response.products;
        });
      } else {
        setState(() {
          isLoading = false;
          _products = [];
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          SizedBox(
            width: 100,
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () async {
                        if (_selectedIds.isNotEmpty) {
                          var selectedproducts = _products
                              .takeWhile((element) =>
                                  _selectedIds.any((s) => s == element.id))
                              .toList();
                          var prices = [];
                          var totalprice = 0.0;
                          if (selectedproducts.isNotEmpty) {
                            prices =
                                selectedproducts.map((e) => e.price).toList();
                            if (prices.isNotEmpty) {
                              totalprice = prices.reduce((value, element) =>
                                  double.parse(value.toString()) +
                                  double.parse(element.toString()));
                            }
                          }
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Expanded(
                                            child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Items selected for checkout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          child: ListView.builder(
                                            padding: const EdgeInsets.all(0),
                                            itemCount: _selectedIds.length,
                                            itemBuilder: (context, index) {
                                              var record = _products.firstWhere(
                                                  (p) =>
                                                      p.id ==
                                                      _selectedIds[index]);
                                              var listtile = ListTile(
                                                leading: Text(record
                                                            .title.length >=
                                                        10
                                                    ? "${record.title.substring(0, 10).toUpperCase()}..."
                                                    : record.title),
                                                title: Text(record.price
                                                    .toString()
                                                    .toUpperCase()),
                                                subtitle: Text(record
                                                    .discountPercentage
                                                    .toString()),
                                                trailing: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _selectedIds
                                                            .removeWhere(
                                                                (element) =>
                                                                    element ==
                                                                    record.id);
                                                      });
                                                      Navigator.pop(
                                                          context, "deleted");
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete)),
                                              );
                                              return Card(
                                                child: listtile,
                                              );
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Total price: ${totalprice}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.76,
                                            child: ElevatedButton(
                                                onPressed: () => false,
                                                child: const Text("Checkout")),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      icon: const Icon(Icons.shopping_bag)),
                )),
                _selectedIds.length > 0
                    ? Expanded(
                        child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _selectedIds.length.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromARGB(255, 225, 237, 223)),
                        ),
                      ))
                    : const SizedBox.shrink()
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                var record = _products[index];
                var listtile = ListTile(
                    title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: ImageViewer(
                        parentContext: context,
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.8,
                        radius: 10,
                        url: record.thumbnail,
                      ),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Card(
                                      child: CarouselSlider(
                                        options: CarouselOptions(height: 300.0),
                                        items: record.images.map((i) {
                                          var image = i
                                              .trim()
                                              .replaceAll('"', "")
                                              .replaceAll("[", "")
                                              .replaceAll("]", "");
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                  child: ImageViewer(
                                                    height: 300,
                                                    width: 300,
                                                    parentContext: context,
                                                    radius: 10,
                                                    url: image,
                                                  ));
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        );
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 100),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  onPressed: () => false,
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )),
                            ),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              record.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ))
                        ],
                      ),
                    ),
                    // Padding(padding: EdgeInsets.only(top: 10)),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    record.description.length >= 30
                        ? Text("${record.description.substring(0, 30)}...")
                        : Text(record.description),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text("Brand: ${record.brand}"),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text("Category: ${record.category}"),
                        )),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Discount: ${record.discountPercentage.toString()}"),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text("Price: ${record.price.toString()}"),
                        )),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text("Rating: ${record.rating.toString()}"),
                        )),
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text("Stock: ${record.stock.toString()}"),
                        )),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor: const MaterialStatePropertyAll(
                                        Color.fromARGB(244, 246, 244, 244)),
                                    textStyle: const MaterialStatePropertyAll(TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                    elevation:
                                        const MaterialStatePropertyAll(20),
                                    fixedSize: MaterialStatePropertyAll(Size(
                                        MediaQuery.of(context).size.width, 45)),
                                    backgroundColor: MaterialStatePropertyAll(
                                        _selectedIds.any((id) => id == record.id)
                                            ? const Color.fromARGB(
                                                255, 211, 202, 167)
                                            : const Color.fromARGB(
                                                255, 255, 204, 0)),
                                    shape: const MaterialStatePropertyAll(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))))),
                                onPressed: () {
                                  var exist =
                                      _selectedIds.any((id) => id == record.id);
                                  if (!exist) {
                                    setState(() {
                                      _selectedIds.add(record.id);
                                    });
                                  }
                                },
                                child: const Text('Add to Cart')),
                          ),
                        ))
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                ));
                return SizedBox(
                  height: 550,
                  child: Card(
                    child: listtile,
                  ),
                );
              },
            ),
            isLoading && !isError
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
