import 'package:flutter/material.dart';

class ProductsFilter extends StatefulWidget {
  const ProductsFilter({Key? key}) : super(key: key);

  @override
  State<ProductsFilter> createState() => _ProductsFilterState();
}

class _ProductsFilterState extends State<ProductsFilter> {
  List<String> _categoryfilter = [];
  List<String> _pricefilter = [];
  List<String> _discountfilter = [];
  List<String> _stockfilter = [];

  @override
  void initState() {
    super.initState();
    var clist = List.generate(5, (index) {
      switch (index) {
        case 0:
          return "smartphone";
        case 1:
          return "refrigerator";
        case 2:
          return "tv";
        case 3:
          return "washing machime";
        case 4:
          return "air condition";
        default:
          return "";
      }
    });
    var plist = List.generate(5, (index) {
      switch (index) {
        case 0:
          return "< 1000";
        case 1:
          return "1000 - 5000";
        case 2:
          return "> 5000";
        case 3:
          return "10000 - 20000";
        case 4:
          return "> 20000";
        default:
          return "";
      }
    });
    var dlist = List.generate(4, (index) {
      switch (index) {
        case 0:
          return "100";
        case 1:
          return "200";
        case 2:
          return "300";
        case 3:
          return "400";
        case 4:
          return "500";
        default:
          return "";
      }
    });
    var slist = List.generate(4, (index) {
      switch (index) {
        case 0:
          return "in stock";
        case 1:
          return "limited stock";
        case 2:
          return "only few left";
        case 3:
          return "out of stock";
        default:
          return "";
      }
    });
    setState(() {
      _categoryfilter = clist;
      _pricefilter = plist;
      _discountfilter = dlist;
      _stockfilter = slist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.topRight,
                    child: _categoryfilter.isNotEmpty
                        ? DropdownButton(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            hint: Text('Filter Category'),
                            items: _categoryfilter
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) => false,
                          )
                        : SizedBox.shrink(),
                  )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: _pricefilter.isNotEmpty
                        ? DropdownButton(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            hint: Text('Filter Price'),
                            items: _pricefilter
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) => false,
                          )
                        : SizedBox.shrink(),
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.center,
                    child: _discountfilter.isNotEmpty
                        ? DropdownButton(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            hint: Text('Filter Discount'),
                            items: _discountfilter
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) => false,
                          )
                        : SizedBox.shrink(),
                  )),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: _stockfilter.isNotEmpty
                        ? DropdownButton(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            hint: Text('Filter Stock'),
                            items: _stockfilter
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) => false,
                          )
                        : SizedBox.shrink(),
                  ))
                ],
              )
            ],
          )),
    );
  }
}
