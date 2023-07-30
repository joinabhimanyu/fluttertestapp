import 'package:flutter/material.dart';
import 'package:fluttertestapp/models/guardian_result.dart';
import 'package:fluttertestapp/services/guardian_service.dart';
import 'package:fluttertestapp/services/hotels_service.dart';
import 'package:fluttertestapp/widgets/custom_search_field.dart';
import 'package:fluttertestapp/widgets/drawer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Choice {
  const Choice({required this.icon, required this.title, required this.type});
  final IconData icon;
  final String title;
  final ChoiceType type;
}

enum ChoiceType { Restaurants, Hotels, Books, Movies }

class GuardiansPage extends StatefulWidget {
  const GuardiansPage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String routeName = "GuardiansPage";

  @override
  State<GuardiansPage> createState() => _GuardiansPageState();
}

class _GuardiansPageState extends State<GuardiansPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  late ScrollController scrollController =
      ScrollController(keepScrollOffset: true);

  static const double PAGE_HEIGHT = 0.70;
  static const int PAGE_SIZE = 10;
  // late Future<GuardianResultWrapper> _future;
  List<Choice> choices = [];
  List<GuardianResult> _results = [];
  int page = 1;
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    var list = List.generate(4, (index) {
      if (index == 0) {
        return const Choice(
            icon: Icons.restaurant,
            title: "Restaurants",
            type: ChoiceType.Restaurants);
      } else if (index == 1) {
        return const Choice(
            icon: Icons.hotel, title: "Hotels", type: ChoiceType.Hotels);
      } else if (index == 2) {
        return const Choice(
            icon: Icons.book, title: "Books", type: ChoiceType.Books);
      } else {
        return const Choice(
            icon: Icons.movie, title: "Movies", type: ChoiceType.Movies);
      }
    });
    tabController =
        TabController(vsync: this, length: list.length, initialIndex: 0);
    scrollController.addListener(
      () async {
        print('current scroll position: ${scrollController.position.pixels}');
        print(
            'max scroll position: ${scrollController.position.maxScrollExtent}');
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent) {
          print('limit reached');
          await fetchGuardingData();
        }
      },
    );
    setState(() {
      choices = list;
      //_future = searchGuardianPlatform(page, 20, "");
    });
    fetchGuardingData();
    super.initState();
  }

  Future<void> fetchGuardingData(
      {String searchterm = "", bool resetValues = false}) async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      var response = await searchGuardianPlatform(
          resetValues == false ? _results : [],
          resetValues == false ? page : 1,
          PAGE_SIZE,
          searchterm);
      if (response.status == "ok") {
        setState(
          () {
            _results = response.results;
            if (resetValues == false) {
              page = page + 1;
            } else {
              page = 1;
            }
            isLoading = false;
          },
        );
        if (resetValues == true) {
          scrollController.jumpTo(0);
        }
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  Widget _renderGuardiansContent() {
    if (isError == true) {
      return const Center(
        child: Text('some error occurred while fetching data '),
      );
    }
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: fetchGuardingData,
          child: ListView.builder(
            controller: scrollController,
            itemCount: _results.length,
            itemBuilder: (context, index) {
              var record = _results[index];
              var listtile = ListTile(
                //leading: Text(record.pillarName),
                // leading: const Icon(
                //   Icons.search,
                //   color: Colors.blue,
                // ),
                title: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        record.webTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            //fontFamily: "Schyler",
                            fontStyle: FontStyle.normal,
                            color: Color.fromARGB(255, 12, 44, 77)),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      // Text(record.webPublicationDate),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 5)),
                          Text(
                            record.sectionName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  await _launchUrl(record.webUrl);
                },
              );
              return Card(
                child: listtile,
              );
            },
          ),
        ),
        isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.shrink()
      ],
    );
  }

  Future<void> _launchUrl(String url, {bool isNewTab = true}) async {
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      print('failed to open external resource');
      throw e;
    }
  }

  Widget _renderChoice(Choice choice) {
    if (choice.type == ChoiceType.Restaurants) {
      return Column(
        children: [
          CustomSearchField(
            hinText: 'Category',
            iconData: Icons.search,
            onSuffixIconClick: (value) async {
              await fetchGuardingData(searchterm: value, resetValues: true);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * PAGE_HEIGHT,
            child: _renderGuardiansContent(),
          )
        ],
      );
    }
    return Card(
      child: Text(choice.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
        isScrollable: false,
        tabs: choices.map((Choice choice) {
          return Tab(
            text: null,
            icon: Icon(
              choice.icon,
              color: Colors.grey.shade700,
            ),
            height: 60,
          );
        }).toList(),
      ),
      // Material(
      //   color: Colors.blue,
      //   child: ,
      // ),
      body: TabBarView(
        controller: tabController,
        children: choices.map((Choice choice) {
          return Container(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * PAGE_HEIGHT,
              width: MediaQuery.of(context).size.width,
              child: _renderChoice(choice),
            ),
          );
        }).toList(),
      ),
    );
  }
}
