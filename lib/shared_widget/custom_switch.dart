import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool? value;
  final String language;
  final Color? backgroundColorOfSelection;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    super.key,
    this.value,
    this.onChanged,
    required this.language,
    this.backgroundColorOfSelection,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? circleAnimation;
  AnimationController? _animationController;
  Color? backgroundColorOfSelection;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    circleAnimation = AlignmentTween(
            begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value! ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController?.reverse();
            } else {
              _animationController?.forward();
            }
            widget.value == false
                ? widget.onChanged!(true)
                : widget.onChanged!(false);
          },
          child: Container(
            width: 40,
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: !widget.value!
                    ? const Color(0xffDFE1E3)
                    : widget.backgroundColorOfSelection),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                alignment: widget.language == "en"
                    ? (!widget.value!
                        ? Alignment.centerLeft
                        : Alignment.centerRight)
                    : (!widget.value!
                        ? Alignment.centerRight
                        : Alignment.centerLeft),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffFFFFFF)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
