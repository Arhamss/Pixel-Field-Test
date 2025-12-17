import 'package:pixelfield_test/exports.dart';

PreferredSizeWidget rentmebeachAppBar({
  required BuildContext context,
  required String title,
  VoidCallback? leadingAction,
  List<Widget>? actions,
  bool? showBackButton = true,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    flexibleSpace: Container(color: AppColors.white),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    forceMaterialTransparency: true,
    centerTitle: false,
    titleSpacing: 0,
    leading: (showBackButton ?? false)
        ? IconButton(
            onPressed: leadingAction ?? () => context.pop(),
            icon: SvgPicture.asset(AssetPaths.dummyIcon),
          )
        : null,
    title: Text(
      title,
      style: context.t3.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.blackPrimary,
      ),
    ),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
    actions: actions,
  );
}
