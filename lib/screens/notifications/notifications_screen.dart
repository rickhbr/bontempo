import 'package:bontempo/blocs/notifications/index.dart';
import 'package:bontempo/blocs/notifications/notifications_bloc.dart';
import 'package:bontempo/components/cards/notification_card.dart';
import 'package:bontempo/components/dialogs/custom_dialog.dart';
import 'package:bontempo/components/general/no_results.dart';
import 'package:bontempo/components/layout/common_header.dart';
import 'package:bontempo/components/loaders/common_card_loader.dart';
import 'package:bontempo/models/notification_model.dart';
import 'package:bontempo/repositories/notification_repository.dart';
import 'package:bontempo/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 50.0;

  List<NotificationModel> _notifications = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<NotificationBloc>(context).add(
      LoadNotificationsEvent(),
    );

    NotificationRepository _notificationRepository =
        new NotificationRepository();
    _notificationRepository.readAll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !_loading) {
      setState(() {
        _loading = true;
      });
      BlocProvider.of<NotificationBloc>(context).add(
        LoadNotificationsEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(414, 896),
    );

    return BlocListener<NotificationBloc, NotificationsState>(
      listener: (BuildContext ctx, NotificationsState state) {
        if (state is ErrorNotificationsState) {
          showScaleDialog(
            context: context,
            child: CustomDialog(
              title: 'Ocorreu um probleminha',
              description: state.errorMessage,
              buttonText: "Fechar",
            ),
          );
        }
        if (state is LoadedNotificationsState) {
          setState(() {
            _notifications.addAll(state.items!);
            _loading = false;
          });
        }
        if (state is UninitializedNotificationsState) {
          setState(() {
            _notifications.clear();
            _loading = false;
          });
        }
      },
      child: SafeArea(
        child: CustomScrollView(
          physics: new ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CommonHeader(
                kToolbarHeight: ScreenUtil().setWidth(72),
                expandedHeight: ScreenUtil().setWidth(120),
                title: 'Notificações',
                description:
                    'Aqui você encontra as notificações que recebeu em nosso app.',
                descriptionPadding: 66.0,
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      ScreenUtil().setWidth(150) -
                      ScreenUtil().setHeight(84),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: ScreenUtil().setHeight(36),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _notifications.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return NotificationCard(
                            notification: _notifications[index],
                          );
                        },
                      ),
                      BlocBuilder<NotificationBloc, NotificationsState>(
                        builder: (BuildContext ctx, NotificationsState state) {
                          if (state is LoadingNotificationsState) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: new List.filled(
                                _notifications.length > 0 ? 1 : 2,
                                CommonCardLoader(),
                              ).toList(),
                            );
                          }
                          if (state is LoadedNotificationsState &&
                              _notifications.length == 0) {
                            return NoResults(
                              text: 'Nenhuma notificação encontrada.',
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
