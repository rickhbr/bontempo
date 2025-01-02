import 'dart:convert';
import 'dart:io';

import 'package:bontempo/blocs/avatar/index.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/repositories/user_repository.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AccountAvatar extends StatefulWidget {
  AccountAvatar({Key? key}) : super(key: key);

  _AccountAvatarState createState() => _AccountAvatarState();
}

class _AccountAvatarState extends State<AccountAvatar> {
  String? _userImage;
  bool _isUploading = true;
  late AvatarBloc avatarBloc;
  final ImagePicker _picker = ImagePicker();

  _AccountAvatarState();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    avatarBloc = BlocProvider.of<AvatarBloc>(context);

    setState(() {
      Map<String, dynamic>? avatarData =
          RepositoryProvider.of<UserRepository>(context)
              .getUserFastParam("avatar");
      String? avatarUrl = avatarData?['url'];

      _userImage = avatarUrl;
      _isUploading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> openCamera() async {
    startUpload();
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        updateAvatar(File(image.path));
      } else {
        setState(() {
          _isUploading = false;
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> openGallery() async {
    startUpload();
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        updateAvatar(File(image.path));
      } else {
        setState(() {
          _isUploading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void startUpload() {
    Navigator.of(context).pop();
  }

  Future<void> updateAvatar(File image) async {
    setState(() {
      _isUploading = true;
    });

    image = await FlutterExifRotation.rotateImage(path: image.path);

    List<int>? resizedImage = await FlutterImageCompress.compressWithFile(
      image.absolute.path,
      minWidth: 400,
      minHeight: 400,
      quality: 80,
    );

    if (resizedImage != null) {
      String base64Image = base64.encode(resizedImage);
      avatarBloc.add(UploadAvatarEvent(base64Image));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(378, 667),
    );
    UserRepository userRepository = UserRepository();

    return BlocListener<AvatarBloc, AvatarState>(
      listener: (context, state) {
        if (state is ErrorAvatarState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ops',
              description: 'Não foi possível alterar a sua foto.',
              buttonText: "Fechar",
            ),
          );
          setState(() {
            _isUploading = false;
          });
        }
        if (state is UploadedAvatarState) {
          setState(() {
            _isUploading = false;
            _userImage = userRepository.user!.avatarUrl;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Wrap(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text('Tirar Foto'),
                        onTap: openCamera,
                      ),
                      ListTile(
                        leading: Icon(Icons.image),
                        title: Text('Selecionar da Galeria'),
                        onTap: openGallery,
                      ),
                      ListTile(
                        title: Text('Cancelar'),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            height: ScreenUtil().setWidth(90),
            width: ScreenUtil().setWidth(90),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFFFFFFF),
                width: 5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, ScreenUtil().setHeight(10)),
                )
              ],
              color: Color(0xFFEEEEEE),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Stack(
                children: [
                  if (this._userImage != null)
                    Image.network(
                      this._userImage!,
                      height: ScreenUtil().setWidth(90),
                      width: ScreenUtil().setWidth(90),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      loadingBuilder: (BuildContext ctx, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                    ),
                  if (this._userImage == null && !_isUploading)
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(0)),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[400],
                          size: ScreenUtil().setSp(40),
                        ),
                      ),
                    ),
                  AnimatedOpacity(
                    opacity: _isUploading ? 1 : 0,
                    duration: Duration(milliseconds: 600),
                    child: Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: SizedBox(
                          height: ScreenUtil().setWidth(30),
                          width: ScreenUtil().setWidth(30),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!_isUploading)
                    Positioned(
                      bottom: Platform.isIOS
                          ? ScreenUtil().setHeight(-45)
                          : ScreenUtil().setHeight(-55),
                      left: ScreenUtil().setWidth(0),
                      child: ClipOval(
                        child: Container(
                          color: Colors.white,
                          height: ScreenUtil().setWidth(80),
                          padding: EdgeInsets.only(top: 7),
                          width: ScreenUtil().setWidth(80),
                          child: Text(
                            'EDITAR',
                            style: TextStyle(
                              color: Color(0xFF6666666),
                              fontSize: ScreenUtil().setSp(9),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
