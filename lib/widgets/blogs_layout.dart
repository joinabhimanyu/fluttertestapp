import 'package:flutter/material.dart';
import 'package:fluttertestapp/widgets/blogs_card.dart';
import 'package:fluttertestapp/widgets/custom_listview.dart';
import 'package:fluttertestapp/widgets/custom_search_field.dart';

class BlogsLayout<T> extends StatelessWidget {
  const BlogsLayout(
      {Key? key,
      required this.future,
      required this.onRefresh,
      required this.imageFieldName,
      required this.bodyFieldName,
      this.wantCustomSearch,
      this.wantCommentsField,
      required this.onCommentsIconClick,
      required this.onSearchIconClick})
      : super(key: key);

  final Future<List<T>> future;
  final Future<void> Function() onRefresh;
  final String imageFieldName;
  final String bodyFieldName;
  final bool? wantCustomSearch;
  final bool? wantCommentsField;
  final void Function(String value) onCommentsIconClick;
  final void Function(String value) onSearchIconClick;

  Widget renderTitle(dynamic record) {
    return BlogsCard(
        record: record,
        imageFieldName: imageFieldName,
        bodyFieldName: bodyFieldName,
        wantCommentsField: wantCommentsField,
        onCommentsIconClick: onCommentsIconClick);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        wantCustomSearch != null && wantCustomSearch == true
            ? CustomSearchField(
                hinText: 'Search',
                iconData: Icons.search,
                onSuffixIconClick: onSearchIconClick,
              )
            : const SizedBox.shrink(),
        const Padding(padding: EdgeInsets.only(top: 0)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.79,
          child: CustomListview<T>(
            future: future,
            onRefresh: onRefresh,
            // renderLeading: renderLeading,
            renderTitle: renderTitle,
            onTapRecord: (args) => false,
            wantContainer: true,
            containerHeight: 420,
          ),
        )
      ],
    );
  }
}
