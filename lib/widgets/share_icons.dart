import 'package:flutter/material.dart';

class ShareIcons extends StatelessWidget {
  const ShareIcons(
      {Key? key,
      required this.parentContext,
      // required this.sharePadding,
      // required this.morePadding,
      // required this.likePadding,
      // required this.containerPadding,
      required this.title,
      required this.wantshareIcon,
      required this.wantLikeIcon})
      : super(key: key);

  // final EdgeInsetsGeometry sharePadding;
  // final EdgeInsetsGeometry morePadding;
  // final EdgeInsetsGeometry likePadding;
  // final EdgeInsetsGeometry containerPadding;

  final BuildContext parentContext;
  final bool wantshareIcon;
  final bool wantLikeIcon;
  final String title;

  void _showModalBottomSheetMenu(BuildContext context, String title) {
    showModalBottomSheet(
        constraints: BoxConstraints(
            maxHeight: 400, maxWidth: MediaQuery.of(context).size.width * 0.97),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.only(top: 0),
            child: ListView(children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                tileColor: Color.fromARGB(255, 56, 140, 224),
                leading: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 222, 225, 228),
                ),
                title: Text(
                  "John Doe",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  title.substring(1, 20),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          wantshareIcon != null && wantshareIcon == true
              ? Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(
                      onPressed: () {
                        _showModalBottomSheetMenu(parentContext, title);
                      },
                      icon: const Icon(Icons.share)),
                )
              : const SizedBox.shrink(),
          wantLikeIcon != null && wantLikeIcon == true
              ? Expanded(
                  child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(
                      onPressed: () => false,
                      icon: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      )),
                ))
              : const SizedBox.shrink(),
          Expanded(
              child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IconButton(
                onPressed: () {
                  _showModalBottomSheetMenu(parentContext, title);
                },
                icon: const Icon(Icons.more_horiz)),
          ))
        ],
      ),
    );
  }
}
