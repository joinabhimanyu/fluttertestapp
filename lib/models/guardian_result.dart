class GuardianResult {
  final String id;
  final String type;
  final String sectionId;
  final String sectionName;
  final String webPublicationDate;
  final String webTitle;
  final String webUrl;
  final String apiUrl;
  final bool isHosted;
  final String pillarId;
  final String pillarName;

  const GuardianResult(
      {required this.id,
      required this.type,
      required this.sectionId,
      required this.sectionName,
      required this.webPublicationDate,
      required this.webTitle,
      required this.webUrl,
      required this.apiUrl,
      required this.isHosted,
      required this.pillarId,
      required this.pillarName});

  factory GuardianResult.fromJSON(Map<String, dynamic> json) {
    return GuardianResult(
        id: json['id'],
        type: json['type'],
        sectionId: json['sectionId'],
        sectionName: json['sectionName'],
        webPublicationDate: json['webPublicationDate'],
        webTitle: json['webTitle'],
        webUrl: json['webUrl'],
        apiUrl: json['apiUrl'],
        isHosted: bool.fromEnvironment(json['isHosted'].toString()),
        pillarId: json['pillarId'],
        pillarName: json['pillarName']);
  }

  Map<String, dynamic> toJSON() => {
        'id': id,
        'type': type,
        'sectionId': sectionId,
        'sectionName': sectionName,
        'webPublicationDate': webPublicationDate,
        'webTitle': webTitle,
        'webUrl': webUrl,
        'apiUrl': apiUrl,
        'isHosted': isHosted,
        'pillarId': pillarId,
        'pillarName': pillarName
      };
}
