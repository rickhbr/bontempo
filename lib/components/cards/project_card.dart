import 'package:auto_size_text/auto_size_text.dart';
import 'package:bontempo/models/project_model.dart';
import 'package:bontempo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel? model;
  final Function()? onTap;

  const ProjectCard({
    Key? key,
    this.onTap,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: ScreenUtil().setWidth(10),
        left: ScreenUtil().setWidth(10),
        top: ScreenUtil().setWidth(15),
        bottom: ScreenUtil().setWidth(15),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.19),
            blurRadius: 12.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ButtonTheme(
          minWidth: double.infinity,
          // height: ScreenUtil().setWidth(130.0),
          child: TextButton(
            onPressed: this.onTap,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                    vertical: ScreenUtil().setWidth(20),
                  ),
                  child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      // minHeight: ScreenUtil().setWidth(82),
                      // maxHeight: ScreenUtil().setWidth(130),
                      minWidth: double.infinity,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              model!.name,
                              maxLines: 1,
                              group: AutoSizeGroup(),
                              textAlign: TextAlign.start,
                              minFontSize: 11,
                              style: TextStyle(
                                color: black,
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700,
                                height: .9,
                              ),
                            ),
                            Icon(
                              Icons.more_vert,
                              color: Colors.grey[500],
                              size: ScreenUtil().setSp(16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(8),
                        ),
                        AutoSizeText(
                          "Cozinha",
                          maxLines: 3,
                          group: AutoSizeGroup(),
                          textAlign: TextAlign.start,
                          minFontSize: 10,
                          style: TextStyle(
                            color: black,
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w300,
                            height: .9,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(6),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(16),
                        ),
                        /*AutoSizeText(
                          "RESPONSÁVEL",
                          maxLines: 3,
                          group: AutoSizeGroup(),
                          textAlign: TextAlign.start,
                          minFontSize: 9,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(9),
                            fontWeight: FontWeight.w400,
                            height: .9,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(8),
                        ),
                        AutoSizeText(
                          "Nome Sobrenome",
                          maxLines: 3,
                          group: AutoSizeGroup(),
                          textAlign: TextAlign.start,
                          minFontSize: 10,
                          style: TextStyle(
                            color: black,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w500,
                            height: .9,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(20),
                        ),*/
                        /*AutoSizeText(
                          "DATA FINALIZAÇÃO",
                          maxLines: 3,
                          group: AutoSizeGroup(),
                          textAlign: TextAlign.start,
                          minFontSize: 9,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(9),
                            fontWeight: FontWeight.w400,
                            height: .9,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(8),
                        ),
                        AutoSizeText(
                          "01/01/2022",
                          maxLines: 3,
                          group: AutoSizeGroup(),
                          textAlign: TextAlign.start,
                          minFontSize: 10,
                          style: TextStyle(
                            color: black,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w500,
                            height: .9,
                          ),
                        ),*/
                        SizedBox(
                          height: ScreenUtil().setWidth(20),
                        ),
                        AutoSizeText(
                          "STATUS",
                          maxLines: 3,
                          group: AutoSizeGroup(),
                          textAlign: TextAlign.start,
                          minFontSize: 9,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenUtil().setSp(9),
                            fontWeight: FontWeight.w400,
                            height: .9,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(8),
                        ),
                        AutoSizeText(
                          model!.status,
                          maxLines: 3,
                          group: AutoSizeGroup(),
                          textAlign: TextAlign.start,
                          minFontSize: 10,
                          style: TextStyle(
                            color: black,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w500,
                            height: .9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
