import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BlankItemView extends StatelessWidget {
  final Function()? onTap;
  final String? buttonText, image, lottie;
  final String title, subtitle;

  const BlankItemView(
      {super.key,
      this.onTap,
      required this.title,
      this.image,
      this.lottie,
      required this.subtitle,
      this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          (image == null)
              ? Container()
              : ClipRRect(
                  child: Image.asset(
                    image!,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
          (lottie == null)
              ? Container()
              : ClipRRect(
                  child: SizedBox(
                    height: 200,
                    child: Lottie.asset(
                      lottie.toString(),
                    ),
                  ),
                ),
          const SizedBox(
            height: 24,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(subtitle),
          const SizedBox(
            height: 12,
          ),
          (onTap == null)
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: onTap,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 38,
                            vertical: 8,
                          ),
                          child: Text(
                            buttonText ?? "Retry",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
