import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class WorkingHoursWidget extends StatelessWidget {
  const WorkingHoursWidget({
    super.key,
    required this.dayName,
    required this.workingHours,
    required this.onSave,
  });
  final String dayName;
  final List<CheckBox> workingHours;
  final Function() onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomText(
                      title: dayName,
                      fontSize: 13,
                      textColor: const Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                    IconButton(
                      onPressed: onSave,
                      icon: const Icon(
                        Icons.edit,
                        color: Color(0xff444444),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 320,
                  child: GridView.builder(
                    itemCount: workingHours.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: workingHours[index].isEnable
                              ? const Color(0xff4CB6EA)
                              : Colors.grey[400],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: CustomText(
                            title: workingHours[index].value,
                            fontSize: 13,
                            textColor: workingHours[index].isEnable
                                ? const Color(0xff444444)
                                : const Color(0xffffffff),
                            fontWeight: workingHours[index].isEnable
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            color: const Color(0xff444444),
          )
        ],
      ),
    );
  }
}
