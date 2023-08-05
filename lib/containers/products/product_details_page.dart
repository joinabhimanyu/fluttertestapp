import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertestapp/models/product_model.dart';
import 'package:fluttertestapp/services/product_service.dart';
import 'package:fluttertestapp/widgets/image_viewer.dart';

enum FillType { full, empty }

class RFill {
  const RFill({required this.fill});
  final FillType fill;
}

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;
  static const String routeName = "ProductDetails";
  final ProductModel data;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductModel? _product;
  bool isLoading = false;
  List<int> _selectedIds = [];
  List<int> _quantityOptions = [];
  int _currentReviewPageNo = 1;
  static const int PAGE_SIZE = 10;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    setState(() {
      isLoading = true;
    });
    var list = List.generate(5, (index) {
      switch (index) {
        case 0:
          return 1;
        case 1:
          return 5;
        case 2:
          return 10;
        case 3:
          return 15;
        case 4:
          return 20;
        default:
          return 0;
      }
    });
    return Future.delayed(
      Duration(milliseconds: 2000),
      () {
        setState(() {
          _product = widget.data;
          isLoading = false;
          _quantityOptions = list;
        });
      },
    );
  }

  Future<void> _loadMoreReviews() async {
    setState(() {
      isLoading = true;
    });
    var reviews = await fetchMoreReviews(_currentReviewPageNo, PAGE_SIZE);
    _product!.reviews.addAll(reviews);
    setState(() {
      _product = _product;
      isLoading = false;
      _currentReviewPageNo = _currentReviewPageNo + 1;
    });
  }

  Widget _renderRatings(double rating) {
    var basevalue = rating.floor();
    var list = List<RFill>.generate(5, (index) {
      if (index <= basevalue - 1) {
        return RFill(fill: FillType.full);
      }
      return RFill(fill: FillType.empty);
    });
    return Container(
      width: 200,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: list
              .map((e) => e.fill == FillType.full
                  ? const Icon(
                      Icons.star,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.star,
                      color: Colors.white,
                    ))
              .toList()
          // List<Widget>.generate(list.length, (index) => Icon(Icons.star, color: Colors.green,)).toList()
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          _product != null
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          child: CarouselSlider(
                            options: CarouselOptions(height: 300.0),
                            items: _product!.images.map((i) {
                              var image = i
                                  .trim()
                                  .replaceAll('"', "")
                                  .replaceAll("[", "")
                                  .replaceAll("]", "");
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: const BoxDecoration(
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 100),
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
                                  _product!.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            ],
                          ),
                        ),
                        // Padding(padding: EdgeInsets.only(top: 10)),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        _product!.description.length >= 30
                            ? Text(
                                "${_product!.description.substring(0, 30)}...")
                            : Text(_product!.description),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: Align(
                              alignment: Alignment.center,
                              child: Text("Brand: ${_product!.brand}"),
                            )),
                            Expanded(
                                child: Align(
                              alignment: Alignment.center,
                              child: Text("Category: ${_product!.category}"),
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
                                  "Discount: ${_product!.discountPercentage.toString()}"),
                            )),
                            Expanded(
                                child: Align(
                              alignment: Alignment.center,
                              child:
                                  Text("Price: ${_product!.price.toString()}"),
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
                              child: Column(
                                children: [
                                  // Text("Rating: ${_product.rati
                                  _renderRatings(_product!.rating),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text('${_product!.reviews.length} reviews')
                                ],
                              ),
                            )),
                            Expanded(
                                child: Align(
                              alignment: Alignment.center,
                              child:
                                  Text("Stock: ${_product!.stock.toString()}"),
                            )),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        _quantityOptions.length > 0
                            ? Column(
                                children: [
                                  DropdownButtonFormField(
                                    hint: Text('Choose Quantity'),
                                    items: _quantityOptions
                                        .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.toString())))
                                        .toList(),
                                    onChanged: (value) {
                                      print('value');
                                    },
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 10)),
                                ],
                              )
                            : SizedBox.shrink(),
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
                                        textStyle:
                                            const MaterialStatePropertyAll(
                                                TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                        elevation:
                                            const MaterialStatePropertyAll(20),
                                        fixedSize: MaterialStatePropertyAll(Size(
                                            MediaQuery.of(context).size.width,
                                            45)),
                                        backgroundColor: MaterialStatePropertyAll(
                                            _selectedIds.any((id) => id == _product!.id)
                                                ? const Color.fromARGB(
                                                    255, 211, 202, 167)
                                                : const Color.fromARGB(
                                                    255, 255, 204, 0)),
                                        shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))))),
                                    onPressed: () {
                                      var exist = _selectedIds
                                          .any((id) => id == _product!.id);
                                      if (!exist) {
                                        setState(() {
                                          _selectedIds.add(_product!.id);
                                        });
                                      }
                                    },
                                    child: const Text('Add to Cart')),
                              ),
                            ))
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
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
                                        textStyle:
                                            const MaterialStatePropertyAll(
                                                TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                        elevation:
                                            const MaterialStatePropertyAll(20),
                                        fixedSize: MaterialStatePropertyAll(Size(
                                            MediaQuery.of(context).size.width,
                                            45)),
                                        backgroundColor: MaterialStatePropertyAll(
                                            _selectedIds.any(
                                                    (id) => id == _product!.id)
                                                ? const Color.fromARGB(
                                                    255, 211, 202, 167)
                                                : Color.fromARGB(255, 255, 170, 0)),
                                        shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))))),
                                    onPressed: () {
                                      var exist = _selectedIds
                                          .any((id) => id == _product!.id);
                                      if (!exist) {
                                        setState(() {
                                          _selectedIds.add(_product!.id);
                                        });
                                      }
                                    },
                                    child: const Text('Buy Now')),
                              ),
                            ))
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(children: [
                              Expanded(
                                  child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "User Reviews",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () async {
                                        await _loadMoreReviews();
                                      },
                                      child: Text("Load more...")),
                                ),
                              )
                            ])),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            itemCount: _product!.reviews.length,
                            itemBuilder: (context, index) {
                              var review = _product!.reviews[index];
                              var listtile = ListTile(
                                leading: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: CircleAvatar(),
                                      )),
                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(review.username.length >= 5
                                            ? review.username.substring(0, 5)
                                            : review.username),
                                      ))
                                    ],
                                  ),
                                ),
                                title: Text(review.review),
                                subtitle: Text(review.reviewedon.toString()),
                              );
                              return Card(
                                child: listtile,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
