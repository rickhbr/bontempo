import 'package:flutter/material.dart';
import 'package:bontempo/theme/theme.dart';

class CommonButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final double height;
  final bool bordered;
  final bool alwaysFilled;
  final Function()? onTap;
  final CustomTheme theme;

  const CommonButton({
    Key? key,
    required this.child,
    this.onTap,
    this.padding,
    height,
    bordered,
    alwaysFilled,
    theme,
    margin,
  })  : this.margin = margin ?? EdgeInsets.zero,
        this.height = height ?? 60,
        this.bordered = bordered ?? true,
        this.alwaysFilled = alwaysFilled ?? false,
        this.theme = theme ?? CustomTheme.black,
        super(key: key);

  void handleClick() {
    if (this.onTap != null) {
      this.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    switch (this.theme) {
      case CustomTheme.transparent:
        decoration = BoxDecoration(
          color: Colors.transparent,
          border: bordered
              ? Border.all(
                  width: 1,
                  color: Colors.black.withOpacity(
                      this.onTap != null || this.alwaysFilled ? 1 : .3),
                )
              : null,
        );
        break;
      case CustomTheme.white:
        decoration = BoxDecoration(
          color: Colors.white
              .withOpacity(this.onTap != null || this.alwaysFilled ? 1 : .3),
          border: bordered
              ? Border.all(
                  width: 1,
                  color: black[200]!.withOpacity(
                      this.onTap != null || this.alwaysFilled ? 1 : .3),
                )
              : null,
        );
        break;
      case CustomTheme.green:
        decoration = BoxDecoration(
          color: Colors.green
              .withOpacity(this.onTap != null || this.alwaysFilled ? 1 : .3),
          border: bordered
              ? Border.all(
                  width: 1,
                  color: Colors.green.withOpacity(
                      this.onTap != null || this.alwaysFilled ? 1 : .3),
                )
              : null,
        );
        break;
      case CustomTheme.grey:
        decoration = BoxDecoration(
          color: black[50]!
              .withOpacity(this.onTap != null || this.alwaysFilled ? 1 : .3),
          border: bordered
              ? Border.all(
                  width: 1,
                  color: black[50]!.withOpacity(
                      this.onTap != null || this.alwaysFilled ? 1 : .3),
                )
              : null,
        );
        break;
      default:
        decoration = BoxDecoration(
          color: black[300]!
              .withOpacity(this.onTap != null || this.alwaysFilled ? 1 : .3),
          border: bordered
              ? Border.all(
                  width: 1,
                  color: black[300]!.withOpacity(
                      this.onTap != null || this.alwaysFilled ? 1 : .3),
                )
              : null,
        );
    }

    return Container(
      margin: this.margin,
      height: this.height,
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        child: ButtonTheme(
          minWidth: double.infinity,
          height: this.height,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: this.padding ?? EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onPressed: this.handleClick,
            child: this.child,
          ),
        ),
      ),
    );
  }
}
