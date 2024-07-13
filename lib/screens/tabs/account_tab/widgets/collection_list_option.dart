import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/profile_options.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class CollectionListOptionView extends StatelessWidget {
  const CollectionListOptionView({super.key, required this.listOfOptions});
  final List<ProfileOptions> listOfOptions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listOfOptions.length,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) => const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Divider(),
              ),
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () => listOfOptions[index].avaliable
                  ? listOfOptions[index].onTap()
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      listOfOptions[index].icon,
                      size: 20,
                      color: listOfOptions[index].avaliable
                          ? listOfOptions[index].iconColor
                          : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            title: listOfOptions[index].name,
                            fontSize: 16,
                            textColor: listOfOptions[index].avaliable
                                ? listOfOptions[index].nameColor
                                : Colors.grey,
                            fontWeight: FontWeight.w500),
                        if (listOfOptions[index].subtitle != "")
                          CustomText(
                              title: listOfOptions[index].subtitle,
                              fontSize: 12,
                              textColor: listOfOptions[index].avaliable
                                  ? listOfOptions[index].nameColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w500)
                        else
                          const SizedBox(),
                      ],
                    ),
                    Expanded(child: const SizedBox()),
                    if (listOfOptions[index].selectedItem != "")
                      CustomText(
                        title: listOfOptions[index].selectedItem,
                        fontSize: 14,
                        textColor: const Color(0xffFFA200),
                      )
                    else
                      const SizedBox(),
                    if (listOfOptions[index].selectedItemImage != null)
                      listOfOptions[index].selectedItemImage!
                    else
                      const SizedBox(),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                      color: Color(0xffBFBFBF),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
