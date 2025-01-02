import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final Function? onChange;
  final String? label;
  final CustomTheme theme;

  final bool? initialValue;

  CustomCheckbox({
    Key? key,
    this.onChange,
    this.label,
    this.initialValue,
    theme,
  })  : this.theme = theme ?? CustomTheme.white,
        super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool? value;

  @override
  void initState() {
    setState(() {
      this.value = widget.initialValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          setState(() {
            this.value = this.value == true ? false : true;
          });
          widget.onChange!();
        },
        child: Stack(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFE3E3E3),
                        width: 1,
                      ),
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(30),
                      // ),
                    ),
                    margin: EdgeInsets.only(top: 10),
                    height: 25,
                    width: 25,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 15,
                      left: 10,
                      top: 18,
                    ),
                    child: Text(
                      widget.label!,
                      style: TextStyle(
                        color: widget.theme == CustomTheme.white
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 15,
              left: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: this.value == true ? 1 : 0,
                child: Icon(
                  const IconData(
                    58826,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: widget.theme == CustomTheme.white
                      ? Colors.white
                      : Colors.black,
                  size: 25,
                ),
              ),
            ),
            Positioned(
              top: -6,
              left: -25,
              child: Opacity(
                opacity: 0,
                child: Checkbox(
                  value: this.value ?? false,
                  onChanged: (value) {
                    setState(() {
                      this.value = this.value == true ? false : true;
                    });
                    widget.onChange!();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
