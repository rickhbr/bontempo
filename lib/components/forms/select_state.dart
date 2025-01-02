import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectState extends StatefulWidget {
  final Function onSelected;

  const SelectState({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  bool _loaded = true;
  String _selected = "Estado";
  final List<String> _states = [
    "Acre",
    "Alagoas",
    "Amapá",
    "Amazonas",
    "Bahia",
    "Ceará",
    "Distrito Federal",
    "Espírito Santo",
    "Goiás",
    "Maranhão",
    "Mato Grosso",
    "Mato Grosso do Sul",
    "Minas Gerais",
    "Pará",
    "Paraíba",
    "Paraná",
    "Pernambuco",
    "Piauí",
    "Rio de Janeiro",
    "Rio Grande do Norte",
    "Rio Grande do Sul",
    "Rondônia",
    "Roraima",
    "Santa Catarina",
    "São Paulo",
    "Sergipe",
    "Tocantins",
  ];

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(18)),
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selected == "Estado" ? null : _selected,
                  hint: Text(
                    _selected,
                    style: TextStyle(
                      color: black[200],
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  icon: _loaded
                      ? Icon(
                          Icons.keyboard_arrow_down,
                          color: black[200],
                          size: ScreenUtil().setSp(18),
                        )
                      : loader(),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selected = newValue!;
                    });
                    widget.onSelected(newValue);
                  },
                  items: _states.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
