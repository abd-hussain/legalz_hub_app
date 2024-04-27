import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:legalz_hub_app/main_context.dart';
import 'package:legalz_hub_app/screens/main_container/main_container_bloc.dart';
import 'package:legalz_hub_app/services/attorney/attorney_account_experiance_service.dart';
import 'package:legalz_hub_app/services/attorney/attorney_account_service.dart';
import 'package:legalz_hub_app/services/attorney/attorney_appointments_service.dart';
import 'package:legalz_hub_app/services/attorney/attorney_hour_rate_service.dart';
import 'package:legalz_hub_app/services/attorney/attorney_payment_services.dart';
import 'package:legalz_hub_app/services/attorney/attorney_register_service.dart';
import 'package:legalz_hub_app/services/attorney/attorney_settings_service.dart';
import 'package:legalz_hub_app/services/attorney/working_hours_services.dart';
import 'package:legalz_hub_app/services/auth_services.dart';
import 'package:legalz_hub_app/services/comment_post_services.dart';
import 'package:legalz_hub_app/services/customer/attorney_details_service.dart';
import 'package:legalz_hub_app/services/customer/attorney_list_service.dart';
import 'package:legalz_hub_app/services/customer/customer_account_service.dart';
import 'package:legalz_hub_app/services/customer/customer_appointments_service.dart';
import 'package:legalz_hub_app/services/customer/customer_register_service.dart';
import 'package:legalz_hub_app/services/discount_service.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/services/general/authentication_service.dart';
import 'package:legalz_hub_app/services/general/network_info_service.dart';
import 'package:legalz_hub_app/services/home_services.dart';
import 'package:legalz_hub_app/services/noticitions_services.dart';
import 'package:legalz_hub_app/services/post_services.dart';
import 'package:legalz_hub_app/services/report_service.dart';
import 'package:legalz_hub_app/services/settings_service.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/repository/http_interceptor.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:local_auth/local_auth.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.pushNewScope();
  locator.registerLazySingleton(MainContext.new);
  locator.registerSingleton<MainContainerBloc>(MainContainerBloc());

  locator.registerSingleton<NetworkInfoService>(NetworkInfoService());

  locator.registerFactory<FilterService>(FilterService.new);
  locator.registerFactory<AuthService>(AuthService.new);
  locator.registerFactory<DiscountService>(DiscountService.new);
  locator.registerFactory<HomeService>(HomeService.new);
  locator.registerFactory<NotificationsService>(NotificationsService.new);
  locator.registerFactory<ReportService>(ReportService.new);
  locator.registerFactory<SettingService>(SettingService.new);
  locator.registerFactory<CustomerRegisterService>(CustomerRegisterService.new);
  locator.registerFactory<AttorneyRegisterService>(AttorneyRegisterService.new);

  locator.registerFactory<AttorneyAccountExperianceService>(AttorneyAccountExperianceService.new);
  locator.registerFactory<AttorneyAccountService>(AttorneyAccountService.new);

  locator.registerFactory<CustomerAccountService>(CustomerAccountService.new);
  locator.registerFactory<AttorneyListService>(AttorneyListService.new);
  locator.registerFactory<PostService>(PostService.new);
  locator.registerFactory<CommentPostService>(CommentPostService.new);

  locator.registerFactory<AttorneyAppointmentsService>(AttorneyAppointmentsService.new);
  locator.registerFactory<AttorneyHourRateService>(AttorneyHourRateService.new);
  locator.registerFactory<PaymentService>(PaymentService.new);
  locator.registerFactory<CustomerAppointmentsService>(CustomerAppointmentsService.new);
  locator.registerFactory<AttorneyDetailsService>(AttorneyDetailsService.new);

  locator.registerFactory<AttorneySettingsService>(AttorneySettingsService.new);
  locator.registerFactory<WorkingHoursService>(WorkingHoursService.new);

  locator.registerLazySingleton(AuthenticationService.new);
  locator.registerLazySingleton(LocalAuthentication.new);
  locator.registerSingleton<DayTime>(DayTime());

  locator.registerFactory<Dio>(Dio.new);
  locator.registerFactory<HttpInterceptor>(HttpInterceptor.new);
  locator.registerSingleton<HttpRepository>(HttpRepository());
}
