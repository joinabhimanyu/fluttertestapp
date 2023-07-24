import 'package:flutter/material.dart';
import 'package:fluttertestapp/models/posts_model.dart';

class EditPostDetails extends StatefulWidget {
  const EditPostDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;
  static const String routeName = "EditPost";
  final PostsModel data;

  @override
  State<EditPostDetails> createState() => _EditPostDetailsState();
}

class _EditPostDetailsState extends State<EditPostDetails> {
  late PostsModel post;

  final TextEditingController _titleController =
      TextEditingController(text: '');
  final TextEditingController _bodyController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    setState(() {
      post = widget.data;
    });
    _titleController.text = widget.data.title;
    _bodyController.text = widget.data.body;
  }

  Widget _buildTextFormFields(String value, String fieldname) {
    Widget formField = const Text('No data found');
    switch (fieldname) {
      case 'Title':
        formField = TextFormField(
          controller: _titleController,
        );
        break;
      case 'Body':
        formField = TextFormField(
          controller: _bodyController,
        );
        break;
      default:
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$fieldname :',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        formField,
        const Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
  }

  Widget _buildTextFields(int value, String fieldname) {
    var fieldvalue = '';
    switch (fieldname) {
      case 'UserId':
        fieldvalue = post.userId.toString();
        break;
      case 'Id':
        fieldvalue = post.id.toString();
        break;
      default:
    }
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$fieldname :',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Text(fieldvalue.toString()),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
      ],
    );
  }

  Future<void> _sowContextMenu(Offset globalPosition) async {
    double left = globalPosition.dx;
    double top = globalPosition.dy;
    // 220, 350, 60, 200
    var result = await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, left, 0),
        items: [
          const PopupMenuItem<dynamic>(
              value: "save",
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'save',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              )),
          const PopupMenuItem<dynamic>(
              value: "delete",
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'delete',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              )),
          const PopupMenuItem<dynamic>(
              value: 'reset',
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'reset',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              )),
          const PopupMenuItem<dynamic>(
              value: 'copy',
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'copy',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ))
        ]);
    print('option pressed: $result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 10, top: 5),
              child: Icon(Icons.more_vert),
            ),
            onTapDown: (details) {
              _sowContextMenu(details.globalPosition);
            },
          )
          // IconButton(onPressed: () => false, icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildTextFields(post.userId, 'UserId'),
            _buildTextFields(post.id, 'Id'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            _buildTextFormFields(post.title, 'Title'),
            _buildTextFormFields(post.body, 'Body'),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
              onTapDown: (details) {
                // _sowContextMenu(details.globalPosition);
                Navigator.pushNamed(context, "test route");
              },
            )
          ],
        ),
      ),
    );
  }
}
