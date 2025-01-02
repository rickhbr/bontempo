import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String? avatarUrl;

  const Avatar({
    Key? key,
    this.avatarUrl,
    double? size,
  })  : this.size = size ?? 65,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(this.size),
      width: ScreenUtil().setWidth(this.size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: ClipOval(
        child: this.avatarUrl != null
            ? Image.network(
                this.avatarUrl!,
                height: ScreenUtil().setWidth(this.size),
                width: ScreenUtil().setWidth(this.size),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                loadingBuilder: (BuildContext ctx, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              )
            : Center(
                child: Image.asset(
                  'assets/images/icon.png',
                  height: ScreenUtil().setWidth(this.size / 2),
                  width: ScreenUtil().setWidth(this.size / 2),
                ),
              ),
      ),
    );
  }
}
