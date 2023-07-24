import 'package:flutter/material.dart';

class CustomListview<T> extends StatelessWidget {
  const CustomListview(
      {Key? key,
      required this.future,
      this.onRefresh,
      this.renderLeading,
      this.renderTitle,
      this.onTapRecord,
      this.containerHeight,
      this.wantContainer})
      : super(key: key);

  final Future<List<T>> future;
  final Future<void> Function()? onRefresh;
  final Widget Function(dynamic record)? renderLeading;
  final Widget Function(dynamic record)? renderTitle;
  final void Function(dynamic record)? onTapRecord;
  final double? containerHeight;
  final bool? wantContainer;

  Widget _renderListTile(T record) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 5, bottom: 10),
      leading: renderLeading != null ? renderLeading!.call(record) : null,
      title: renderTitle != null ? renderTitle!.call(record) : null,
      onTap: () => onTapRecord != null ? onTapRecord!.call(record) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData &&
            snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data as List<T>;
          return RefreshIndicator(
              onRefresh: onRefresh!,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final record = data[index];
                  var listTile = _renderListTile(record);
                  if (wantContainer != null && wantContainer == true) {
                    return Container(
                      height: containerHeight ?? 100,
                      child: Card(
                        child: listTile,
                      ),
                    );
                  }
                  return Card(
                    child: listTile,
                  );
                },
              ));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return const Text('Not loaded');
      },
    );
  }
}
