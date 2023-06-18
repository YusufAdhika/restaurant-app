import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/restaurant_controller.dart';
import 'package:restaurant_api/data/enum/result_state.dart';
import 'package:restaurant_api/widgets/blank_massage.dart';
import 'package:restaurant_api/widgets/loading_custom.dart';

class ReviewView extends StatelessWidget {
  ReviewView({required this.id, super.key});

  final controller = Get.put(RestaurantController());
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Review",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Name :"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 18,
                            right: 0,
                            top: 16,
                            bottom: 16,
                          ),
                          hintText: "Enter Name",
                          border: InputBorder.none),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      onChanged: (text) {
                        controller.nameText.text = text;
                      },
                    ),
                  ),
                ),
                const Text("Review :"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 18,
                          right: 0,
                          top: 16,
                          bottom: 16,
                        ),
                        border: InputBorder.none,
                        hintText: "Enter Review",
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      onChanged: (text) {
                        controller.reviewText.text = text;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    if (controller.nameText.text.isNotEmpty &&
                        controller.reviewText.text.isNotEmpty) {
                      controller.postReview(
                        id,
                        controller.nameText.text,
                        controller.reviewText.text,
                      );
                      controller.nameText.text = "";
                      controller.reviewText.text = "";
                    } else {
                      Get.snackbar(
                        "Failed",
                        "Fill name field and review field",
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(() {
            switch (controller.reviewState.value) {
              case ResultState.loading:
                return const CLoading();
              case ResultState.noData:
                return const BlankItemView(
                  title: "No Restaurant Review",
                  subtitle: "Please enter review",
                );
              case ResultState.hasData:
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.reviewList.length,
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 0,
                  ),
                  itemBuilder: (context, index) {
                    var data = controller.reviewList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Divider(
                          height: 0,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            const Text("Name    : "),
                            Text(
                              data.name.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Review  : "),
                            SizedBox(
                              width: 240,
                              child: Text(
                                data.review.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Date      : "),
                            Text(
                              data.date.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Divider(
                          height: 0,
                        )
                      ],
                    );
                  },
                );
              case ResultState.error:
                return const BlankItemView(
                  image: "assets/wifi.png",
                  title: "Error Connection",
                  subtitle: "Please Check your Internet",
                );
              default:
                return const SizedBox();
            }
          })
        ],
      ),
    );
  }
}
