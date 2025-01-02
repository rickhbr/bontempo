import 'package:bontempo/components/loaders/sized_box_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquareImage extends StatelessWidget {
  final double width;
  final double height;
  final String? imageUrl;
  final String? imageAsset;
  final dynamic imageMemory;
  final IconData noImage;

  const SquareImage({
    Key? key,
    this.imageUrl,
    this.imageAsset,
    this.imageMemory,
    double? width,
    double? height,
    IconData? noImage,
  })  : this.width = width ?? 148.0,
        this.height = height ?? 130.0,
        this.noImage = noImage ?? Icons.image,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(this.width),
      width: ScreenUtil().setWidth(this.height),
      color: Colors.grey[300]?.withOpacity(this.imageUrl != null ? 0.2 : 1),
      child: this.imageUrl != null && this.imageUrl != ''
          ? Image.network(
              this.imageUrl!,
              height: ScreenUtil().setWidth(this.width),
              width: ScreenUtil().setWidth(this.height),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Center(
                  child: Icon(
                    this.noImage,
                    color: Colors.grey[400],
                    size: ScreenUtil().setSp(36),
                  ),
                );
              },
              loadingBuilder: (BuildContext ctx, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBoxLoader(
                      height: ScreenUtil().setWidth(this.width),
                      width: ScreenUtil().setWidth(this.height),
                    ),
                    CircularProgressIndicator(
                      strokeWidth: 1,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ],
                );
              },
            )
          : this.imageAsset != null && this.imageAsset != ''
              ? Image.asset(
                  this.imageAsset!,
                  height: ScreenUtil().setWidth(this.width),
                  width: ScreenUtil().setWidth(this.height),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                )
              : this.imageMemory != null && this.imageMemory != ''
                  ? Image.memory(
                      this.imageMemory,
                      height: ScreenUtil().setWidth(this.width),
                      width: ScreenUtil().setWidth(this.height),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                  : Center(
                      child: Icon(
                        this.noImage,
                        color: Colors.grey[400],
                        size: ScreenUtil().setSp(36),
                      ),
                    ),
    );
  }
}
