import 'package:fluttertestapp/models/guardian_result.dart';

class GuardianResultWrapper {
  final String status;
  final String userTier;
  final int total;
  final int startIndex;
  final int pageSize;
  final int currentPage;
  final int pages;
  final String orderBy;
  final List<GuardianResult> results;

  const GuardianResultWrapper(
      {required this.status,
      required this.userTier,
      required this.total,
      required this.startIndex,
      required this.pageSize,
      required this.currentPage,
      required this.pages,
      required this.orderBy,
      required this.results});

  factory GuardianResultWrapper.fromJSON(Map<String, dynamic> json) {
    return GuardianResultWrapper(
        status: json['status'],
        userTier: json['userTier'],
        total: int.parse(json['total'].toString()),
        startIndex: int.parse(json['startIndex'].toString()),
        pageSize: int.parse(json['pageSize'].toString()),
        currentPage: int.parse(json['currentPage'].toString()),
        pages: int.parse(json['pages'].toString()),
        orderBy: json['orderBy'],
        results: (json['results'] as List<dynamic>)
            .map((e) => GuardianResult.fromJSON(e))
            .toList());
  }
}
