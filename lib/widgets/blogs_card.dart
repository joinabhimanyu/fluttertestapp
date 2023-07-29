import 'package:flutter/material.dart';
import 'package:fluttertestapp/widgets/custom_search_field.dart';
import 'package:fluttertestapp/widgets/image_viewer.dart';
import 'package:fluttertestapp/widgets/share_icons.dart';

class BlogsCard extends StatelessWidget {
  const BlogsCard(
      {Key? key,
      required this.record,
      required this.imageFieldName,
      required this.bodyFieldName,
      this.wantCommentsField,
      required this.onCommentsIconClick})
      : super(key: key);

  final dynamic record;
  final String imageFieldName;
  final String bodyFieldName;
  final bool? wantCommentsField;
  final void Function(String value) onCommentsIconClick;

  @override
  Widget build(BuildContext context) {
    final json = record.toJSON();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ImageViewer(
          parentContext: context,
          url: json[imageFieldName],
          width: MediaQuery.of(context).size.width,
          height: 200,
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            json[bodyFieldName].toString().length >= 60
                ? json[bodyFieldName].toString().substring(0, 60)
                : json[bodyFieldName].toString(),
            softWrap: true,
            style: const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 22, wordSpacing: 4),
          ),
        ),
        ShareIcons(
            wantLikeIcon: true,
            wantshareIcon: true,
            parentContext: context,
            title: json[bodyFieldName]),
        wantCommentsField != null && wantCommentsField == true
            ? CustomSearchField(
                hinText: 'Add Comments',
                iconData: Icons.comment,
                onSuffixIconClick: onCommentsIconClick,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
