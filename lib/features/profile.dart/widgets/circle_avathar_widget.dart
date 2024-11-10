
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/bottom_navigation/home/repository/home_repository.dart';
import 'package:blizerpay/features/profile.dart/widgets/image_post_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

final homeProvider = Provider<HomeRepository>(
  (ref) {
    return HomeRepository();
  },
);
final personalDetails = FutureProvider<Map<String, dynamic>>(
  (ref) {
    final homeprovider = ref.watch(homeProvider);
    return homeprovider.getPersonalDetailes();
  },
);

class CircularAvatarWithBorderWidget extends ConsumerWidget {
  final String? file;
  final double avatarRadius;
  final Color borderColor;
  final double borderWidth;
  final void Function()? onTap;
  final void Function()? onEditTap;

  const CircularAvatarWithBorderWidget({
    super.key,
    required this.file,
    this.avatarRadius = 50.0,
    this.borderColor = Colors.blue,
    this.borderWidth = 4.0,
    this.onTap,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileControllerData = ref.watch(personalDetails);

    return profileControllerData.when(
        data: (data) {
          return Center(
            child: InkWell(
              onTap: onTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: avatarRadius * 2 + borderWidth,
                    height: avatarRadius * 2 + borderWidth,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: borderColor,
                    ),
                  ),
                  
                 file!.isEmpty ||file==null
                      ?
                       CircleAvatar(
                        backgroundColor:const Color(0xffC4C4C4),
                          radius: avatarRadius,
                          child: SvgPicture.asset(PathConstents.profileicon,height: 40,width: 40,color: Colors.white,),
                        )
                      : CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: NetworkImage(file!),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: InkWell(
                      onTap: onEditTap,
                      child: Container(
                        width: avatarRadius / 2,
                        height: avatarRadius / 2,
                        decoration: BoxDecoration(
                          color: const Color(0xff15508D),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 2.0,
                          ),
                        ),
                        child: Icon(
                          Icons.edit,
                          size: avatarRadius / 3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Stack(
              children: [
                const CircleAvatar(
                  radius: 70,
                  child: Icon(Icons.person),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => const ImagePostOptionWidget(),
                      );
                    },
                    child: Container(
                      width: 70 / 2,
                      height: 70 / 2,
                      decoration: BoxDecoration(
                        color: const Color(0xff15508D),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 70 / 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        loading: () => const SizedBox());
  }
}
