import 'dart:io';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class GalleryButton extends StatefulWidget {
  final Function onSelectImages;
  final Function? onError;

  const GalleryButton({
    Key? key,
    required this.onSelectImages,
    this.onError,
  }) : super(key: key);

  @override
  _GalleryButtonState createState() => _GalleryButtonState();
}

class _GalleryButtonState extends State<GalleryButton> {
  final ImagePicker _picker = ImagePicker();

  Future<void> openGallery() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images == null || images.isEmpty) return;

      List<File> files = images.map((image) => File(image.path)).toList();
      widget.onSelectImages(files);
    } catch (e) {
      if (widget.onError != null) widget.onError!(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(6),
      ),
      theme: CustomTheme.black,
      onTap: this.openGallery,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/gallery.svg',
            height: ScreenUtil().setWidth(23),
            width: ScreenUtil().setWidth(28),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Text(
            'GALERIA DE FOTOS',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
