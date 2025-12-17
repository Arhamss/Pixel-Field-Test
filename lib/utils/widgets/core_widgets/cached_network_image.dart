import 'package:cached_network_image/cached_network_image.dart';
import 'package:pixelfield_test/constants/constants.dart';
import 'package:pixelfield_test/exports.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedImageWidget extends StatelessWidget {
  const CustomCachedImageWidget({
    required this.imageUrl,
    this.placeHolder = '',
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final String placeHolder;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColors.blackPrimary,
          highlightColor: AppColors.blackPrimary,
          child: Container(
            width: width,
            height: height,
            color: AppColors.blackPrimary,
          ),
        ),
        errorWidget: (context, url, error) =>
            Image.asset(placeHolder, width: width, height: height, fit: fit),
      ),
    );
  }
}
