
import 'package:blizerpay/constents/path_constents.dart';
import 'package:blizerpay/features/profile.dart/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

final profileNotifier = ChangeNotifierProvider(
  (ref) {
    return ProfileController();
  },
);

class ImagePostOptionWidget extends ConsumerWidget {
  const ImagePostOptionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifierValu = ref.watch(profileNotifier);
    return notifierValu.deleteIsLoading
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref
                              .read(profileNotifier.notifier)
                              .deletImage(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    ref
                        .read(profileNotifier.notifier)
                        .pickImage(context, ImageSource.camera, ref);
                  },
                  child: Container(
                    width: 175, // Set the desired width
                    height: 52.42, // Set the desired height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(33.82), // Custom radius
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 0.85, // Border width
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(PathConstents.camera),
                        const SizedBox(width: 10),
                        const Text(" Use Camera",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    ref
                        .read(profileNotifier.notifier)
                        .pickImage(context, ImageSource.gallery, ref);
                  },
                  child: Container(
                    width: 175, // Set the desired width
                    height: 52.42, // Set the desired height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(33.82),
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 0.85, // Border width
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(PathConstents.gallery),
                        const SizedBox(width: 10),
                        const Text("Select Gallery",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
