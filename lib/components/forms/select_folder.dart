import 'package:bontempo/models/library_folder_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectFolder extends StatefulWidget {
  final Function onSelected;
  final List<LibraryFolderModel>? folders;

  const SelectFolder({
    Key? key,
    required this.onSelected,
    this.folders,
  }) : super(key: key);

  @override
  _SelectFolderState createState() => _SelectFolderState();
}

class _SelectFolderState extends State<SelectFolder> {
  bool _loaded = true;
  String _selected = "Categoria";
  List<LibraryFolderModel> folders = [];

  @override
  void initState() {
    super.initState();
    if (widget.folders != null) {
      folders = widget.folders!;
    }
  }

  Widget loader() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: ScreenUtil().setWidth(18),
        height: ScreenUtil().setWidth(18),
        child: CircularProgressIndicator(
          strokeWidth: 1,
          valueColor: AlwaysStoppedAnimation<Color>(
            black[200]!,
          ),
        ),
      ),
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Selecione a Categoria'),
              content: SingleChildScrollView(
                child: Column(
                  children: folders.map((item) {
                    return RadioListTile<LibraryFolderModel>(
                      title: Text(item.name),
                      value: item,
                      groupValue: folders.firstWhere(
                          (folder) => folder.name == _selected,
                          orElse: () => folders.first),
                      onChanged: (LibraryFolderModel? selected) {
                        setState(() {
                          _selected = selected!.name;
                        });
                        widget.onSelected(selected);
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(18)),
      child: GestureDetector(
        onTap: () {
          if (_loaded) {
            _showSelectionDialog(context);
          }
        },
        child: Container(
          height: ScreenUtil().setWidth(50),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: black[50]!,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: ButtonTheme(
              minWidth: double.infinity,
              height: ScreenUtil().setWidth(50),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _selected,
                      style: TextStyle(
                        color: black[200],
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (_loaded)
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: black[200],
                        size: ScreenUtil().setSp(18),
                      )
                    else
                      loader(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
