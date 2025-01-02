import 'package:bontempo/components/forms/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/forms/input.dart';
import 'package:bontempo/theme/theme.dart';

class CustomForm extends StatefulWidget {
  final List<Map<String, dynamic>> fields;
  final Widget? submitText;
  final Function onSubmit;
  final bool disabled;
  final CustomTheme theme;
  final CustomTheme buttonTheme;

  CustomForm({
    Key? key,
    required this.fields,
    this.submitText,
    required this.onSubmit,
    disabled,
    theme,
    buttonTheme,
  })  : this.disabled = disabled ?? false,
        this.theme = theme ?? CustomTheme.black,
        this.buttonTheme = buttonTheme ?? theme ?? CustomTheme.black,
        super(key: key);

  _CustomFormState createState() => _CustomFormState(
        this.fields,
        this.submitText,
        this.onSubmit,
        this.disabled,
      );
}

class _CustomFormState extends State<CustomForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Widget? submitText;
  final Function onSubmit;
  final bool disabled;
  List<Map<String, dynamic>> fields;
  List<Widget>? inputs;

  _CustomFormState(
    this.fields,
    this.submitText,
    this.onSubmit,
    this.disabled,
  );

  @override
  void initState() {
    setState(() {
      fields = this.fields.map((el) {
        if (el['component'] != null) return el;
        el['inputFocus'] = new FocusNode();
        el['inputKey'] =
            el['inputKey'] ?? new GlobalKey<FormFieldState<String>>();
        if (el['type'] == 'phone') {
          int lenght = el['initialValue'] != null
              ? el['initialValue'].replaceAll(new RegExp(r'(\D+)'), '').length
              : 0;
          el['inputController'] = new MaskedTextController(
            mask: lenght <= 10 ? '(00) 0000-0000' : '(00) 00000-0000',
          );
          el['inputController'].beforeChange = (String previous, String next) {
            int prevLenght =
                previous.replaceAll(new RegExp(r'(\D+)'), '').length;
            int nextLenght = next.replaceAll(new RegExp(r'(\D+)'), '').length;
            if (prevLenght == 11 && nextLenght <= 10) {
              el['inputController'].updateMask('(00) 0000-0000');
            } else if (prevLenght <= 10 && nextLenght == 11) {
              el['inputController'].updateMask('(00) 00000-0000');
            }
            return nextLenght <= 11;
          };
          el['inputFocus'].addListener(() {
            if (!el['inputFocus'].hasFocus) {
              if (el['inputController'].text.length < 14) {
                el['inputController'].text = '';
              }
            }
          });
          // } else if (el['name'] == 'cpf') {
          //   el['inputController'] = new MaskedTextController(
          //     mask: '000.000.000-00',
          //   );
          //   el['inputFocus'].addListener(() {
          //     if (!el['inputFocus'].hasFocus) {
          //       if (el['inputController'].text.length < 14) {
          //         el['inputController'].text = '';
          //       }
          //     }
          //   });
        } else {
          el['inputController'] =
              el['inputController'] ?? new TextEditingController();
        }
        if (el['equalTo'] != null) {
          el['equalTo'] = this.fields.firstWhere(
              (field) => field['name'] == el['equalTo'])['inputController'];
        }
        return el;
      }).toList();
    });
    super.initState();
  }

  void changeFocus(
    BuildContext context,
    String name,
    FocusNode currentFocus,
  ) {
    currentFocus.unfocus();

    int index = this.fields.indexWhere((el) => el['name'] == name) + 1;
    if (this.fields.length > index) {
      FocusScope.of(context).requestFocus(this.fields[index]['inputFocus']);
    } else {
      this._submit();
    }
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      Map<String, dynamic> data = {};
      this.fields.forEach((el) {
        el['inputFocus'].unfocus();

        dynamic value;
        if (el['type'] == 'checkbox') {
          value = (el['value'] == true) ? 1 : 0;
        } else
          value = el['inputController'].text;

        data.putIfAbsent(el['name'], () => value);
      });
      form.save();
      this.onSubmit(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...this.fields.map((el) {
            dynamic currentField;

            if (el['type'] == 'checkbox') {
              List<Map<String, dynamic>> newFields = fields;
              int index = 0;
              this.fields.forEach((searchField) {
                if (searchField['name'] == el['name']) {
                  newFields[index]['value'] = fields[index]['value'] != null
                      ? fields[index]['value']
                      : el['initialValue'];
                  fields[index] = newFields[index];
                  this.fields = fields;
                }
                index++;
              });

              currentField = CustomCheckbox(
                initialValue: el['initialValue'] == true ? true : false,
                label: el['labelText'],
                theme: widget.theme,
                onChange: () {
                  setState(() {
                    List<Map<String, dynamic>> newFields = fields;
                    index = 0;
                    this.fields.forEach((searchField) {
                      if (searchField['name'] == el['name']) {
                        bool currentVal = fields[index]['value'] != null
                            ? fields[index]['value']
                            : el['initialValue'];

                        newFields[index]['value'] =
                            currentVal == true ? false : true;
                        fields[index] = newFields[index];
                        this.fields = fields;

                        if (el['onChange'] != null &&
                            el['onChange'] is Function) {
                          el['onChange'](newFields[index]['value']);
                        }
                      }
                      index++;
                    });
                  });
                },
              );
            } else {
              currentField = Input(
                inputKey: el['inputKey'],
                inputFocus: el['inputFocus'],
                inputController: el['inputController'],
                name: el['name'],
                type: el['type'],
                initialValue: el['initialValue'] ?? null,
                labelText: el['labelText'] ?? null,
                hintText: el['hintText'] ?? null,
                isRequired: el['isRequired'] ?? null,
                multiLine: el['multiLine'] ?? null,
                capitalize: el['capitalize'],
                readOnly: el['readOnly'] ?? null,
                equalTo: el['equalTo'] ?? null,
                expands: el['expands'] ?? null,
                minLength: el['minLength'] ?? null,
                onEditingComplete: this.changeFocus,
                theme: widget.theme,
              );
            }

            return Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
              child: currentField,
            );
          }).toList(),
          if (submitText != null)
            SizedBox(
              height: ScreenUtil().setWidth(30),
            ),
          if (submitText != null)
            CommonButton(
              theme: widget.buttonTheme,
              onTap: !this.disabled ? this._submit : null,
              child: submitText!,
              height: 40.0,
            ),
        ],
      ),
    );
  }
}
