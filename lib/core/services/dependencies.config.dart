// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_local_datasource.dart'
    as _i992;
import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_admin_session_usecase.dart'
    as _i453;
import '../../features/auth/domain/usecases/submit_sign_in_usecase.dart'
    as _i1061;
import '../../features/auth/domain/usecases/submit_sign_out_usecase.dart'
    as _i961;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/categories/data/datasources/categories_remote_datasource.dart'
    as _i16;
import '../../features/categories/data/repositories/categories_repository_impl.dart'
    as _i245;
import '../../features/categories/domain/repositories/categories_repository.dart'
    as _i488;
import '../../features/categories/domain/usecases/create_category_usecase.dart'
    as _i431;
import '../../features/categories/domain/usecases/delete_category_usecase.dart'
    as _i1007;
import '../../features/categories/domain/usecases/get_categories_usecase.dart'
    as _i76;
import '../../features/categories/domain/usecases/update_categories_order_usecase.dart'
    as _i824;
import '../../features/categories/domain/usecases/update_category_usecase.dart'
    as _i656;
import '../../features/categories/presentation/cubit/categories_cubit.dart'
    as _i802;
import '../../features/categories/presentation/cubit/category_editor_cubit.dart'
    as _i167;
import '../../features/licenses/data/datasources/licenses_remote_datasource.dart'
    as _i238;
import '../../features/licenses/data/repositories/licenses_repository_impl.dart'
    as _i685;
import '../../features/licenses/domain/repositories/licenses_repository.dart'
    as _i129;
import '../../features/licenses/domain/usecases/get_approved_licenses_usecase.dart'
    as _i217;
import '../../features/licenses/domain/usecases/get_inbox_licenses_usecase.dart'
    as _i390;
import '../../features/licenses/domain/usecases/get_license_by_id_usecase.dart'
    as _i619;
import '../../features/licenses/domain/usecases/get_license_counts_usecase.dart'
    as _i567;
import '../../features/licenses/domain/usecases/get_license_usecase.dart'
    as _i452;
import '../../features/licenses/domain/usecases/get_licenses_page_usecase.dart'
    as _i785;
import '../../features/licenses/domain/usecases/update_license_access_usecase.dart'
    as _i664;
import '../../features/licenses/domain/usecases/update_license_profile_usecase.dart'
    as _i805;
import '../../features/licenses/presentation/cubit/license_editor_cubit.dart'
    as _i446;
import '../../features/licenses/presentation/cubit/licenses_cubit.dart'
    as _i192;
import '../../features/questions/data/datasources/image_picker_local_datasource.dart'
    as _i484;
import '../../features/questions/data/datasources/image_upload_remote_datasource.dart'
    as _i796;
import '../../features/questions/data/datasources/questions_remote_datasource.dart'
    as _i195;
import '../../features/questions/data/repositories/questions_repository_impl.dart'
    as _i416;
import '../../features/questions/domain/repositories/questions_repository.dart'
    as _i358;
import '../../features/questions/domain/usecases/create_question_usecase.dart'
    as _i833;
import '../../features/questions/domain/usecases/delete_question_usecase.dart'
    as _i749;
import '../../features/questions/domain/usecases/get_picked_image_usecase.dart'
    as _i1069;
import '../../features/questions/domain/usecases/get_questions_usecase.dart'
    as _i309;
import '../../features/questions/domain/usecases/update_question_usecase.dart'
    as _i351;
import '../../features/questions/domain/usecases/upload_question_image_usecase.dart'
    as _i537;
import '../../features/questions/presentation/cubit/question_editor_cubit.dart'
    as _i715;
import '../../features/questions/presentation/cubit/questions_cubit.dart'
    as _i19;
import '../../features/shell/presentation/cubit/shell_cubit.dart' as _i68;
import 'dependencies.dart' as _i372;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    final platformModule = _$PlatformModule();
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i183.ImagePicker>(() => platformModule.imagePicker);
    gh.lazySingleton<_i519.Client>(() => platformModule.httpClient);
    gh.lazySingleton<_i460.SharedPreferencesAsync>(
      () => platformModule.preferences,
    );
    gh.lazySingleton<_i68.ShellCubit>(() => _i68.ShellCubit());
    gh.factory<_i992.LocalAuthDatasource>(
      () => _i992.LocalAuthDatasourceImpl(gh<_i460.SharedPreferencesAsync>()),
    );
    gh.factory<_i161.RemoteAuthDatasource>(
      () => _i161.RemoteAuthDatasourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i484.LocalImagePickerDatasource>(
      () => _i484.LocalImagePickerDatasourceImpl(gh<_i183.ImagePicker>()),
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i161.RemoteAuthDatasource>(),
        gh<_i992.LocalAuthDatasource>(),
      ),
    );
    gh.factory<_i796.RemoteImageUploadDatasource>(
      () => _i796.RemoteImageUploadDatasourceImpl(gh<_i519.Client>()),
    );
    gh.factory<_i238.RemoteLicensesDatasource>(
      () => _i238.RemoteLicensesDatasourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i16.RemoteCategoriesDatasource>(
      () => _i16.RemoteCategoriesDatasourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i195.RemoteQuestionsDatasource>(
      () => _i195.RemoteQuestionsDatasourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i453.GetAdminSessionUsecase>(
      () => _i453.GetAdminSessionUsecase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i1061.SubmitSignInUsecase>(
      () => _i1061.SubmitSignInUsecase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i961.SubmitSignOutUsecase>(
      () => _i961.SubmitSignOutUsecase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        gh<_i453.GetAdminSessionUsecase>(),
        gh<_i1061.SubmitSignInUsecase>(),
        gh<_i961.SubmitSignOutUsecase>(),
      ),
    );
    gh.factory<_i488.CategoriesRepository>(
      () =>
          _i245.CategoriesRepositoryImpl(gh<_i16.RemoteCategoriesDatasource>()),
    );
    gh.factory<_i129.LicensesRepository>(
      () => _i685.LicensesRepositoryImpl(gh<_i238.RemoteLicensesDatasource>()),
    );
    gh.factory<_i431.CreateCategoryUsecase>(
      () => _i431.CreateCategoryUsecase(gh<_i488.CategoriesRepository>()),
    );
    gh.factory<_i1007.DeleteCategoryUsecase>(
      () => _i1007.DeleteCategoryUsecase(gh<_i488.CategoriesRepository>()),
    );
    gh.factory<_i76.GetCategoriesUsecase>(
      () => _i76.GetCategoriesUsecase(gh<_i488.CategoriesRepository>()),
    );
    gh.factory<_i824.UpdateCategoriesOrderUsecase>(
      () =>
          _i824.UpdateCategoriesOrderUsecase(gh<_i488.CategoriesRepository>()),
    );
    gh.factory<_i656.UpdateCategoryUsecase>(
      () => _i656.UpdateCategoryUsecase(gh<_i488.CategoriesRepository>()),
    );
    gh.lazySingleton<_i802.CategoriesCubit>(
      () => _i802.CategoriesCubit(
        gh<_i76.GetCategoriesUsecase>(),
        gh<_i824.UpdateCategoriesOrderUsecase>(),
      ),
    );
    gh.factory<_i358.QuestionsRepository>(
      () => _i416.QuestionsRepositoryImpl(
        gh<_i195.RemoteQuestionsDatasource>(),
        gh<_i796.RemoteImageUploadDatasource>(),
        gh<_i484.LocalImagePickerDatasource>(),
      ),
    );
    gh.factory<_i217.GetApprovedLicensesUsecase>(
      () => _i217.GetApprovedLicensesUsecase(gh<_i129.LicensesRepository>()),
    );
    gh.factory<_i390.GetInboxLicensesUsecase>(
      () => _i390.GetInboxLicensesUsecase(gh<_i129.LicensesRepository>()),
    );
    gh.factory<_i619.GetLicenseByIdUsecase>(
      () => _i619.GetLicenseByIdUsecase(gh<_i129.LicensesRepository>()),
    );
    gh.factory<_i567.GetLicenseCountsUsecase>(
      () => _i567.GetLicenseCountsUsecase(gh<_i129.LicensesRepository>()),
    );
    gh.factory<_i452.GetLicenseUsecase>(
      () => _i452.GetLicenseUsecase(gh<_i129.LicensesRepository>()),
    );
    gh.factory<_i785.GetLicensesPageUsecase>(
      () => _i785.GetLicensesPageUsecase(gh<_i129.LicensesRepository>()),
    );
    gh.factory<_i664.UpdateLicenseAccessUsecase>(
      () => _i664.UpdateLicenseAccessUsecase(gh<_i129.LicensesRepository>()),
    );
    gh.factory<_i805.UpdateLicenseProfileUsecase>(
      () => _i805.UpdateLicenseProfileUsecase(gh<_i129.LicensesRepository>()),
    );
    gh.factory<_i167.CategoryEditorCubit>(
      () => _i167.CategoryEditorCubit(
        gh<_i431.CreateCategoryUsecase>(),
        gh<_i656.UpdateCategoryUsecase>(),
        gh<_i1007.DeleteCategoryUsecase>(),
      ),
    );
    gh.factory<_i833.CreateQuestionUsecase>(
      () => _i833.CreateQuestionUsecase(gh<_i358.QuestionsRepository>()),
    );
    gh.factory<_i749.DeleteQuestionUsecase>(
      () => _i749.DeleteQuestionUsecase(gh<_i358.QuestionsRepository>()),
    );
    gh.factory<_i1069.GetPickedImageUsecase>(
      () => _i1069.GetPickedImageUsecase(gh<_i358.QuestionsRepository>()),
    );
    gh.factory<_i309.GetQuestionsUsecase>(
      () => _i309.GetQuestionsUsecase(gh<_i358.QuestionsRepository>()),
    );
    gh.factory<_i351.UpdateQuestionUsecase>(
      () => _i351.UpdateQuestionUsecase(gh<_i358.QuestionsRepository>()),
    );
    gh.factory<_i537.UploadQuestionImageUsecase>(
      () => _i537.UploadQuestionImageUsecase(gh<_i358.QuestionsRepository>()),
    );
    gh.factory<_i715.QuestionEditorCubit>(
      () => _i715.QuestionEditorCubit(
        gh<_i833.CreateQuestionUsecase>(),
        gh<_i351.UpdateQuestionUsecase>(),
        gh<_i749.DeleteQuestionUsecase>(),
        gh<_i1069.GetPickedImageUsecase>(),
        gh<_i537.UploadQuestionImageUsecase>(),
      ),
    );
    gh.lazySingleton<_i192.LicensesCubit>(
      () => _i192.LicensesCubit(
        gh<_i390.GetInboxLicensesUsecase>(),
        gh<_i785.GetLicensesPageUsecase>(),
        gh<_i567.GetLicenseCountsUsecase>(),
        gh<_i217.GetApprovedLicensesUsecase>(),
        gh<_i619.GetLicenseByIdUsecase>(),
        gh<_i664.UpdateLicenseAccessUsecase>(),
      ),
    );
    gh.factory<_i446.LicenseEditorCubit>(
      () => _i446.LicenseEditorCubit(
        gh<_i452.GetLicenseUsecase>(),
        gh<_i664.UpdateLicenseAccessUsecase>(),
        gh<_i805.UpdateLicenseProfileUsecase>(),
      ),
    );
    gh.lazySingleton<_i19.QuestionsCubit>(
      () => _i19.QuestionsCubit(gh<_i309.GetQuestionsUsecase>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i372.FirebaseModule {}

class _$PlatformModule extends _i372.PlatformModule {}
