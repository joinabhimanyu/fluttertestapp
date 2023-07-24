import 'package:flutter/material.dart';

class ShareIcons extends StatelessWidget {
  const ShareIcons(
      {Key? key,
      required this.sharePadding,
      required this.morePadding,
      required this.parentContext,
      required this.title,
      required this.wantshareIcon})
      : super(key: key);

  final EdgeInsetsGeometry sharePadding;
  final EdgeInsetsGeometry morePadding;
  final BuildContext parentContext;
  final bool wantshareIcon;
  final String title;

  void _showModalBottomSheetMenu(BuildContext context, String title) {
    showModalBottomSheet(
        constraints: const BoxConstraints(maxHeight: 400),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.only(top: 15),
            child: ListView(children: [
              ListTile(
                leading: const CircleAvatar(),
                title: const Text("John Doe"),
                subtitle: Text(title.substring(1, 20)),
              ),
              const Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: const <Widget>[
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Share on Facebook'),
                    ),
                    ListTile(
                      leading: Icon(Icons.ios_share),
                      title: Text('Share on Whatsapp'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Share on Gmail'),
                    ),
                    ListTile(
                      leading: Icon(Icons.rate_review),
                      title: Text('Rate this photo'),
                    ),
                    ListTile(
                      leading: Icon(Icons.report),
                      title: Text('Report abuse'),
                    )
                  ],
                ),
              )
              // ElevatedButton(
              //     child: const Text("Button"), onPressed: () => print("Pressed"))
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        wantshareIcon != null && wantshareIcon == true
            ? Container(
                padding: sharePadding,
                child: IconButton(
                    onPressed: () {
                      _showModalBottomSheetMenu(parentContext, title);
                    },
                    icon: const Icon(Icons.share)),
              )
            : const SizedBox.shrink(),
        Container(
          padding: morePadding,
          child: IconButton(
              onPressed: () {
                _showModalBottomSheetMenu(parentContext, title);
              },
              icon: const Icon(Icons.more_horiz)),
        )
      ],
    );
  }
}
