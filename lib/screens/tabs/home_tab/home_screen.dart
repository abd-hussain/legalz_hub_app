import 'package:flutter/material.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/models/https/home_banners_response.dart';
import 'package:legalz_hub_app/models/https/home_posts_response.dart';
import 'package:legalz_hub_app/screens/main_container/main_container_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/home_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/bottom_sheets/post_comments_bottomsheet.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/bottom_sheets/report_post_bottomsheet.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/posts/add_new_post_top_view.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/home_header_view.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/main_banner.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/posts/post_list_view.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/tab_bar.dart';
import 'package:legalz_hub_app/shared_widget/bottom_sheet_util.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/shared_widget/shimmers/shimmer_home_page.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/logger.dart';
import 'package:legalz_hub_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:legalz_hub_app/utils/push_notifications/notification_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final bloc = HomeBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Home init Called ...');
    NotificationManager.init(context: context);
    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer" ? UserType.customer : UserType.attorney;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });
    bloc.reportList = bloc.fillReportList(context);
    bloc.callRegisterTokenRequest();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FutureBuilder<List<Category>>(
          initialData: const [],
          future: locator<MainContainerBloc>().getlistOfCategories(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bloc.tabController = TabController(initialIndex: 0, length: snapshot.data!.length, vsync: this);
              bloc.handleTapControllerListener();
              return Column(
                children: [
                  HomeHeaderView(
                    userType: bloc.userType,
                    listOfCategories: snapshot.data!,
                    addPost: ({required catId, required content, postImg}) async {
                      await bloc.addNewPost(catId: catId, content: content, postImg: postImg);
                    },
                  ),
                  DefaultTabController(
                    length: snapshot.data!.length,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 40,
                          child: CustomTabBar(
                            tabController: bloc.tabController,
                            userType: bloc.userType,
                            tabs: List.generate(
                              snapshot.data!.length,
                              (index) {
                                return CustomTab(tabName: snapshot.data![index].name!);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        RefreshIndicator(
                          onRefresh: bloc.pullRefresh,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 300,
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: bloc.tabController,
                              children: snapshot.data!.map((sub) {
                                return _tabBarView(listOfCategories: snapshot.data!, item: sub);
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const ShimmerHomePage();
            }
          }),
    );
  }

  Widget _tabBarView({required List<Category> listOfCategories, required Category item}) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            bloc.userType == UserType.customer
                ? AddNewPostTopView(
                    listOfCategories: listOfCategories,
                    addPost: ({required catId, required content, postImg}) async {
                      await bloc.addNewPost(catId: catId, content: content, postImg: postImg);
                    },
                  )
                : Container(),
            const SizedBox(height: 8),
            item.id! == 0
                ? FutureBuilder<List<HomeBannerResponseData>?>(
                    initialData: const [],
                    future: bloc.getHomeBanners(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null && snapshot.hasData) {
                        return const SizedBox(height: 220, child: LoadingView());
                      } else {
                        return MainBannerHomePage(bannerList: snapshot.data ?? []);
                      }
                    })
                : Container(),
            item.id! == 0 ? const SizedBox(height: 8) : Container(),
            StreamBuilder<List<PostResponseData>?>(
                initialData: const [],
                stream: bloc.postsStreamController.stream,
                builder: (context, snapshot) {
                  return PostsListView(
                    currentUserType: bloc.userType,
                    box: bloc.box,
                    postsList: snapshot.data,
                    commentsAction: (postId) async {
                      bloc.getPostComments(postId: postId).then((value) async {
                        await PostCommentsBottomSheetsUtil().bottomSheet(
                            context: context,
                            comments: value.data,
                            currentUserType: bloc.userType,
                            currentUserId: bloc.box.get(DatabaseFieldConstant.userid),
                            addCommentCallBack: (comment) async {
                              await bloc.addNewComment(postId: postId, content: comment);
                            },
                            deleteCommentCallBack: (commentId) async {
                              BottomSheetsUtil().areYouShoureButtomSheet(
                                  context: context,
                                  message: AppLocalizations.of(context)!.areyousuredeletcomment,
                                  sure: () async {
                                    bloc.deleteComment(commentId: commentId).then((value) {
                                      bloc.getHomePosts(catId: 0, skip: 0);
                                    });
                                  });
                            });
                      });
                    },
                    editPostAction: (postId) {
                      //TODO: handle edit post
                    },
                    deleteAction: (postId) {
                      BottomSheetsUtil().areYouShoureButtomSheet(
                          context: context,
                          message: AppLocalizations.of(context)!.areyousuredeletepost,
                          sure: () async {
                            bloc.deletePost(postId: postId).then((value) {
                              bloc.getHomePosts(catId: 0, skip: 0);
                            });
                          });
                    },
                    reportAction: (postId) {
                      ReportPostBottomSheetsUtil().bottomSheet(
                          context: context,
                          reporsList: bloc.reportList,
                          reportAction: (report) async {
                            await bloc.reportPost(
                                postId: postId, reason: '${report.title} : ${report.desc} : ${report.otherNote}');
                          });
                    },
                  );
                }),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
