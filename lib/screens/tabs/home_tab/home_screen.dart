import 'package:flutter/material.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/models/https/home_banners_response.dart';
import 'package:legalz_hub_app/screens/main_container/main_container_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/home_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/home_header_view.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/main_banner.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
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

class _HomeTabScreenState extends State<HomeTabScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final bloc = HomeBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Home init Called ...');
    NotificationManager.init(context: context);
    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });
    bloc.reportList = bloc.fillReportList(context);
    bloc.callRegisterTokenRequest(context);
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
              bloc.tabController =
                  TabController(length: snapshot.data!.length, vsync: this);
              // bloc.handleTapControllerListener();
              return Column(
                children: [
                  HomeHeaderView(
                    userType: bloc.userType,
                    listOfCategories: snapshot.data!,
                    enableAddPost: false,
                    addPost: (
                        {required catId, required content, postImg}) async {
                      // await bloc.addNewPost(catId: catId, content: content, postImg: postImg);
                    },
                  ),
                  FutureBuilder<List<HomeBannerResponseData>?>(
                      initialData: const [],
                      future: bloc.getHomeBanners(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null && snapshot.hasData) {
                          return const SizedBox(
                              height: 220, child: LoadingView());
                        } else {
                          return MainBannerHomePage(
                              bannerList: snapshot.data ?? []);
                        }
                      }),
                  const SizedBox(height: 100),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: CustomText(
                        title: AppLocalizations.of(context)!
                            .questionandandwerscomingsoon,
                        fontSize: 18,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        maxLins: 2,
                        textColor: const Color(0xff554d56),
                      ),
                    ),
                  )

                  // DefaultTabController(
                  //   length: snapshot.data!.length,
                  //   child:
                  // Column(
                  //   children: [
                  //     SizedBox(
                  //       height: 40,
                  //       child: CustomTabBar(
                  //         tabController: bloc.tabController,
                  //         userType: bloc.userType,
                  //         tabs: List.generate(
                  //           snapshot.data!.length,
                  //           (index) {
                  //             return CustomTab(tabName: snapshot.data![index].name!);
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(height: 8),
                  // SizedBox(
                  //   //         height: MediaQuery.of(context).size.height - 200,
                  //   child:
                  // TabBarView(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   controller: bloc.tabController,
                  //   children: snapshot.data!.map((sub) {
                  //     return _tabBarView(listOfCategories: snapshot.data!, item: sub);
                  //   }).toList(),
                  // ),
                  //  ),
                  //   ],
                  // ),
                  //  ),
                ],
              );
            } else {
              return const ShimmerHomePage();
            }
          }),
    );
  }

  // Widget _tabBarView({required List<Category> listOfCategories, required Category item}) {
  //   final ScrollController _scrollController = ScrollController();

  //   _scrollController.addListener(() async {
  //     if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
  //       bloc.skipPost = bloc.skipPost + 10;
  //       await bloc.getHomePosts(catId: bloc.tabController!.index, skip: bloc.skipPost, newRequest: false);
  //     }
  //   });
  //   return Expanded(
  //     child: RefreshIndicator(
  //       onRefresh: bloc.pullRefresh,
  //       child: SingleChildScrollView(
  //         controller: _scrollController,
  //         child: Column(
  //           children: [
  //             if (bloc.userType == UserType.customer)
  //               AddNewPostTopView(
  //                 listOfCategories: listOfCategories,
  //                 addPost: ({required catId, required content, postImg}) async {
  //                   await bloc.addNewPost(catId: catId, content: content, postImg: postImg);
  //                 },
  //               )
  //             else
  //              const SizedBox(),
  //             const SizedBox(height: 8),
  //             if (item.id! == 0)
  //               FutureBuilder<List<HomeBannerResponseData>?>(
  //                   initialData: const [],
  //                   future: bloc.getHomeBanners(),
  //                   builder: (context, snapshot) {
  //                     if (snapshot.data == null && snapshot.hasData) {
  //                       return const SizedBox(height: 220, child: LoadingView());
  //                     } else {
  //                       return MainBannerHomePage(bannerList: snapshot.data ?? []);
  //                     }
  //                   })
  //             else
  //               const SizedBox(),
  //             if (item.id! == 0) const SizedBox(height: 8) else const SizedBox(),
  //             StreamBuilder<List<PostResponseData>?>(
  //                 initialData: const [],
  //                 stream: bloc.postsStreamController.stream,
  //                 builder: (context, snapshot) {
  //                   return PostsListView(
  //                     currentUserType: bloc.userType,
  //                     box: bloc.box,
  //                     postsList: snapshot.data,
  //                     categories: listOfCategories,
  //                     commentsAction: (postId) async {
  //                       try {
  //                         await bloc.getPostComments(postId: postId).then((value) async {
  //                           await PostCommentsBottomSheetsUtil().bottomSheet(
  //                               context: context,
  //                               comments: value.data,
  //                               currentUserType: bloc.userType,
  //                               currentUserId: bloc.box.get(DatabaseFieldConstant.userid),
  //                               addCommentCallBack: (comment) async {
  //                                 try {
  //                                   await bloc.addNewComment(postId: postId, content: comment);
  //                                 } on ConnectionException {
  //                                   final scaffoldMessenger = ScaffoldMessenger.of(context);
  //                                   scaffoldMessenger.showSnackBar(
  //                                     SnackBar(
  //                                         content:
  //                                             Text(AppLocalizations.of(context)!.pleasecheckyourinternetconnection)),
  //                                   );
  //                                 }
  //                               },
  //                               deleteCommentCallBack: (commentId) async {
  //                                 await BottomSheetsUtil().areYouShoureButtomSheet(
  //                                     context: context,
  //                                     message: AppLocalizations.of(context)!.areyousuredeletcomment,
  //                                     sure: () async {
  //                                       try {
  //                                         await bloc.deleteComment(commentId: commentId).then((value) {
  //                                           bloc.skipPost = 0;
  //                                           bloc.getHomePosts(catId: 0, skip: bloc.skipPost, newRequest: true);
  //                                         });
  //                                       } on ConnectionException {
  //                                         final scaffoldMessenger = ScaffoldMessenger.of(context);
  //                                         scaffoldMessenger.showSnackBar(
  //                                           SnackBar(
  //                                               content: Text(
  //                                                   AppLocalizations.of(context)!.pleasecheckyourinternetconnection)),
  //                                         );
  //                                       }
  //                                     });
  //                               });
  //                         });
  //                       } on ConnectionException {
  //                         final scaffoldMessenger = ScaffoldMessenger.of(context);
  //                         scaffoldMessenger.showSnackBar(
  //                           SnackBar(content: Text(AppLocalizations.of(context)!.pleasecheckyourinternetconnection)),
  //                         );
  //                       }
  //                     },
  //                     editPostAction: ({required catId, required content, required postId, postImg}) async {
  //                       await bloc.editPost(postId: postId, catId: catId, content: content, postImg: postImg);
  //                     },
  //                     deleteAction: (postId) {
  //                       BottomSheetsUtil().areYouShoureButtomSheet(
  //                           context: context,
  //                           message: AppLocalizations.of(context)!.areyousuredeletepost,
  //                           sure: () async {
  //                             await bloc.deletePost(postId: postId).then((value) {
  //                               bloc.skipPost = 0;

  //                               bloc.getHomePosts(catId: 0, skip: bloc.skipPost, newRequest: true);
  //                             });
  //                           });
  //                     },
  //                     reportAction: (postId) {
  //                       ReportPostBottomSheetsUtil().bottomSheet(
  //                           context: context,
  //                           reporsList: bloc.reportList,
  //                           reportAction: (report) async {
  //                             try {
  //                               await bloc.reportPost(
  //                                   postId: postId, reason: '${report.title} : ${report.desc} : ${report.otherNote}');
  //                             } on ConnectionException {
  //                               final scaffoldMessenger = ScaffoldMessenger.of(context);
  //                               scaffoldMessenger.showSnackBar(
  //                                 SnackBar(
  //                                     content: Text(AppLocalizations.of(context)!.pleasecheckyourinternetconnection)),
  //                               );
  //                             }
  //                           });
  //                     },
  //                   );
  //                 }),
  //             const SizedBox(height: 10)
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  bool get wantKeepAlive => true;
}
