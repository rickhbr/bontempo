import 'dart:async';
import 'dart:io';
import 'package:bontempo/components/buttons/camera_button.dart';
import 'package:bontempo/components/buttons/common_button.dart';
import 'package:bontempo/components/buttons/gallery_button.dart';
import 'package:bontempo/components/layout/common_back_header.dart';
import 'package:bontempo/components/layout/layout_pushed.dart';
import 'package:bontempo/constants/routes.dart';
import 'package:bontempo/screens/clothes_config/clothes_config_arguments.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClothesAddScreen extends StatefulWidget {
  @override
  _ClothesAddScreenState createState() => _ClothesAddScreenState();
}

class _ClothesAddScreenState extends State<ClothesAddScreen> {
  bool isUploading = true;
  List<File> images = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> addFile(File file) async {
    if (!mounted) return;
    setState(() {
      images = List.from(images)..insert(0, file);
    });
  }

  Future<void> addImages(List<File> files) async {
    if (!mounted) return;
    setState(() {
      images = List.from(images)..insertAll(0, files);
    });
  }

  void removeImageAt(int index) {
    setState(() {
      images = List.from(images)..removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return LayoutPushed(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CommonBackHeader(
                title: 'Adicionar Peça',
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  bottom: ScreenUtil().setHeight(36),
                  top: ScreenUtil().setWidth(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CameraButton(
                      onTakePicture: this.addFile,
                    ),
                    GalleryButton(
                      onSelectImages: this.addImages,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(30),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: ScreenUtil().setWidth(14),
                        runSpacing: ScreenUtil().setWidth(18),
                        children: List.generate(
                          images.length,
                          (index) {
                            return Container(
                              key: Key('item-${index.toString()}'),
                              height: ScreenUtil().setWidth(135),
                              width: ScreenUtil().setWidth(170),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 5,
                                  color: Colors.black,
                                ),
                              ),
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image.file(
                                    images[index],
                                    fit: BoxFit.contain,
                                    height: ScreenUtil().setWidth(135),
                                    width: ScreenUtil().setWidth(170),
                                  ),
                                  Positioned(
                                    top: ScreenUtil().setWidth(3),
                                    right: ScreenUtil().setWidth(3),
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      color: Colors.transparent,
                                      child: ButtonTheme(
                                        padding: EdgeInsets.zero,
                                        minWidth: ScreenUtil().setWidth(22),
                                        height: ScreenUtil().setWidth(22),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                        ),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          child: Container(
                                            width: ScreenUtil().setWidth(22),
                                            height: ScreenUtil().setWidth(22),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey[600]!,
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.close,
                                                size: ScreenUtil().setSp(14),
                                                color: black[200],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            this.removeImageAt(index);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      footer: CommonButton(
        bordered: false,
        theme: CustomTheme.green,
        height: ScreenUtil().setHeight(84),
        onTap: this.images.length > 0
            ? () {
                Navigator.pushNamed(
                  context,
                  ClothesConfigViewRoute,
                  arguments: ClothesConfigArguments(images: this.images),
                );
              }
            : null,
        child: Text(
          this.images.length > 0 ? 'AVANÇAR' : 'CARREGUE AO MENOS UMA FOTO',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
