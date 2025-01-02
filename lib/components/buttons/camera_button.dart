import 'dart:async';
import 'dart:io';

import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class CameraButton extends StatefulWidget {
  final Function(File) onTakePicture;
  final Function(String)? onError;

  const CameraButton({
    Key? key,
    required this.onTakePicture,
    this.onError,
  }) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> openCamera() async {
    try {
      final XFile? imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 90,
      );

      if (imageFile != null) {
        File rotatedImage =
            await FlutterExifRotation.rotateImage(path: imageFile.path);
        widget.onTakePicture(rotatedImage);
      }
    } catch (e) {
      if (widget.onError != null) widget.onError!(e.toString());
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      widget.onTakePicture(File(response.file!.path));
    } else {
      if (widget.onError != null) widget.onError!(response.exception!.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setWidth(6),
      ),
      theme: CustomTheme.black,
      onTap: this.openCamera,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svg/camera.svg',
            height: ScreenUtil().setWidth(22),
            width: ScreenUtil().setWidth(25),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Text(
            'CÂMERA',
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
