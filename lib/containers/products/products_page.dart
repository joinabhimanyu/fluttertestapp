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
                                  padding: EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
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
                                            padding: EdgeInsets.all(0),
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
                                                    icon: Icon(Icons.delete)),
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
                                            style: TextStyle(
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
                                                child: Text("Checkout")),
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
                      icon: Icon(Icons.shopping_bag)),
                )),
                _selectedIds.length > 0
                    ? Expanded(
                        child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _selectedIds.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromARGB(255, 225, 237, 223)),
                        ),
                      ))
                    : SizedBox.shrink()
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
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
                    ImageViewer(
                      parentContext: context,
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.8,
                      radius: 10,
                      url: record.thumbnail,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      record.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    record.description.length >= 30
                        ? Text("${record.description.substring(0, 30)}...")
                        : Text(record.description),
                    Padding(padding: EdgeInsets.only(top: 10)),
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
                    Padding(padding: EdgeInsets.only(top: 10)),
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
                    Padding(padding: EdgeInsets.only(top: 10)),
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
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(244, 246, 244, 244)),
                                    textStyle: MaterialStatePropertyAll(
                                        TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    elevation: MaterialStatePropertyAll(20),
                                    fixedSize: MaterialStatePropertyAll(Size(
                                        MediaQuery.of(context).size.width, 45)),
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 255, 204, 0)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))))),
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
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                ));
                return Container(
                  height: 500,
                  child: Card(
                    child: listtile,
                  ),
                );
              },
            ),
            isLoading && !isError
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
