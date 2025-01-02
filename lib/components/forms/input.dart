import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bontempo/theme/form_decorations.dart';
import 'package:intl/intl.dart';

class Input extends StatefulWidget {
  final String name;
  final String type;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final bool capitalize;
  final bool isRequired;
  final bool readOnly;
  final bool multiLine;
  final bool autoFocus;
  final bool expands;
  final bool showPassword;
  final int? minLength;
  final Function? onEditingComplete;
  final GlobalKey<FormFieldState<String>> inputKey;
  final FocusNode inputFocus;
  final TextEditingController? equalTo;
  final TextEditingController inputController;
  final CustomTheme theme;

  Input({
    Key? key,
    required this.name,
    required this.inputKey,
    required this.inputFocus,
    required this.inputController,
    this.initialValue,
    this.equalTo,
    this.minLength,
    this.labelText,
    this.hintText,
    this.onEditingComplete,
    String? type,
    bool? capitalize,
    bool? isRequired,
    bool? multiLine,
    bool? expands,
    bool? autoFocus,
    bool? showPassword,
    bool? readOnly,
    CustomTheme? theme,
  })  : this.isRequired = isRequired ?? false,
        this.readOnly = readOnly ?? false,
        this.multiLine = multiLine ?? false,
        this.expands = expands ?? false,
        this.autoFocus = autoFocus ?? false,
        this.showPassword = showPassword ?? false,
        this.type = type ?? 'text',
        this.capitalize = capitalize ?? false,
        this.theme = theme ?? CustomTheme.white,
        super(key: key);

  _InputState createState() => _InputState(
        this.inputFocus,
        this.inputController,
        this.onEditingComplete,
      );
}

class _InputState extends State<Input> {
  FocusNode inputFocus;
  TextEditingController inputController;
  late TextInputType keyboardType;
  Function? onEditingComplete;
  bool _hidePassword = true;
  bool touched = false;

  _InputState(
    this.inputFocus,
    this.inputController,
    this.onEditingComplete,
  );

  Future<void> _selectDate() async {
    int year = DateTime.now().year;
    DateTime? picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: this.inputController.text.isNotEmpty
          ? DateTime(
              int.parse(this.inputController.text.substring(6, 10)),
              int.parse(this.inputController.text.substring(3, 5)),
              int.parse(this.inputController.text.substring(0, 2)),
            )
          : DateTime(year - 15),
      firstDate: DateTime(year - 80),
      lastDate: DateTime(year - 15),
      locale: const Locale('pt'),
    );
    if (picked != null) {
      setState(() {
        this.inputController.value =
            TextEditingValue(text: DateFormat('dd/MM/yyyy').format(picked));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.expands) {
        keyboardType = TextInputType.multiline;
      } else {
        switch (widget.type) {
          case 'email':
            keyboardType = TextInputType.emailAddress;
            break;
          case 'phone':
            keyboardType = TextInputType.phone;
            break;
          case 'numeric':
            keyboardType = TextInputType.number;
            break;
          case 'date':
            keyboardType = TextInputType.datetime;
            break;
          default:
            keyboardType = TextInputType.text;
        }
      }
    });
    this.inputController.value =
        TextEditingValue(text: widget.initialValue ?? '');

    this.inputFocus.addListener(() {
      if (!this.inputFocus.hasFocus && mounted) {
        setState(() {
          touched = true;
        });
      }
    });
  }

  void _togglePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  String? _validator(String? value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return 'Este campo é obrigatório';
    }
    if (widget.minLength != null && widget.minLength! > (value?.length ?? 0)) {
      return 'Não deve ter menos de ${widget.minLength.toString()} caracteres';
    }
    if (widget.type == 'email' &&
        value != null &&
        !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Preencha um e-mail válido';
    }
    if (widget.equalTo != null && widget.equalTo!.text != value) {
      return 'As senhas digitadas não são iguais';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    TextFormField _formField = TextFormField(
      key: widget.inputKey,
      controller: this.inputController,
      focusNode: this.inputFocus,
      readOnly: widget.readOnly || widget.type == 'date',
      textInputAction: TextInputAction.next,
      obscureText: widget.type == 'password' && this._hidePassword,
      maxLines: widget.multiLine
          ? 10
          : widget.expands
              ? null
              : 1,
      expands: widget.expands,
      autofocus: widget.autoFocus,
      autocorrect: widget.type != 'email',
      textCapitalization: widget.capitalize == true
          ? TextCapitalization.words
          : TextCapitalization.none,
      decoration: widget.theme == CustomTheme.white
          ? inputWhiteDecoration(
              labelText: widget.labelText!,
              hintText: widget.hintText!,
            )
          : inputDarkDecoration(
              labelText: widget.labelText!,
              hintText: widget.hintText!,
            ),
      validator: this._validator,
      onEditingComplete: () {
        if (widget.inputKey.currentState!.validate() &&
            this.onEditingComplete != null) {
          this.onEditingComplete!(context, widget.name, this.inputFocus);
        }
      },
      style: greyText(weight: FontWeight.w500),
      keyboardType: this.keyboardType,
    );
    if (widget.type == 'date' && !widget.readOnly) {
      return GestureDetector(
        onTap: () {
          this._selectDate();
        },
        child: Container(
          color: Colors.transparent,
          child: IgnorePointer(
            child: _formField,
          ),
        ),
      );
    }
    if (widget.type == 'password' && !widget.showPassword) {
      return Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          _formField,
          Container(
            width: ScreenUtil().setWidth(43),
            height: ScreenUtil().setHeight(43),
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Material(
              color: Colors.transparent,
              child: ButtonTheme(
                minWidth: ScreenUtil().setWidth(43),
                height: ScreenUtil().setHeight(43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: this._togglePassword,
                  child: Center(
                    child: this._hidePassword
                        ? SvgPicture.asset(
                            'assets/svg/eye-show.svg',
                            color: widget.theme == CustomTheme.white
                                ? Colors.white
                                : Colors.grey,
                            height: 22,
                            width: 22,
                          )
                        : SvgPicture.asset(
                            'assets/svg/eye-hide.svg',
                            color: widget.theme == CustomTheme.white
                                ? Colors.white
                                : Colors.grey,
                            height: 22,
                            width: 22,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return _formField;
  }
}
