import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItem extends StatefulWidget {
  final String placeholder;
  final Function callback;
  final bool loading;
  AddItem({
    Key? key,
    required this.placeholder,
    required this.callback,
    loading,
  })  : this.loading = loading ?? false,
        super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _controller = new TextEditingController();

  Future<void> changeInput(String text) async {
    if (!widget.loading && text.isNotEmpty) {
      widget.callback(text);
      await Future.delayed(Duration(milliseconds: 250));
      this._controller.clear();
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              color: black[200]!.withOpacity(.5),
              fontStyle: FontStyle.italic,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
              borderRadius: BorderRadius.all(Radius.zero),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.all(Radius.zero),
            ),
            contentPadding: new EdgeInsets.only(
              top: ScreenUtil().setHeight(15),
              bottom: ScreenUtil().setHeight(15),
              left: ScreenUtil().setWidth(23),
              right: ScreenUtil().setWidth(23),
            ),
          ),
          onSubmitted: this.changeInput,
          style: TextStyle(
            color: black,
            fontSize: ScreenUtil().setSp(15),
          ),
        ),
        if (!widget.loading)
          Padding(
            padding: EdgeInsets.only(
              right: ScreenUtil().setWidth(8),
            ),
            child: SizedBox(
              width: ScreenUtil().setWidth(48),
              height: ScreenUtil().setWidth(48),
              child: CommonButton(
                padding: EdgeInsets.zero,
                theme: CustomTheme.transparent,
                onTap: () {
                  this.changeInput(_controller.text);
                },
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: black,
                    size: ScreenUtil().setSp(24),
                  ),
                ),
              ),
            ),
          )
        else
          Padding(
            padding: EdgeInsets.only(
              right: ScreenUtil().setWidth(23),
            ),
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: ScreenUtil().setWidth(18),
                height: ScreenUtil().setWidth(18),
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    black[200]!,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
