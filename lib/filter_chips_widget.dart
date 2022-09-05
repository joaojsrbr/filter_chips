import 'package:flutter/material.dart';
import 'package:state_change/state_change.dart';
import 'filter_chips_controller.dart';

class FilterChipsWidget extends StatefulWidget {
  final List<String> filters;
  final void Function(List<String> data) onChange;
  const FilterChipsWidget({
    Key? key,
    required this.filters,
    required this.onChange,
  }) : super(key: key);

  @override
  State<FilterChipsWidget> createState() => _FilterChipsWidgetState();
}

class _FilterChipsWidgetState extends State<FilterChipsWidget>
    with AutomaticKeepAliveClientMixin {
  late final List<String> _filters;

  final controller = FilterChipsController();

  @override
  void initState() {
    _filters = [...widget.filters];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      alignment: Alignment.bottomCenter,
      child: StateChange<List<String>>(
        notifier: controller,
        builder: (context, value) => ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          primary: true,
          itemCount: _filters.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onLongPress: null,
              child: FilterChip(
                key: ObjectKey(value),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                    strokeAlign: StrokeAlign.outside,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                side: const BorderSide(width: 0),
                shadowColor: Colors.transparent,
                elevation: 0,
                checkmarkColor: const Color(0xff2A2939),
                backgroundColor: const Color(0xff2A2939),
                selectedColor: const Color(0xff69FF98),
                label: Text(
                  _filters[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selected: value.contains(_filters[index]),
                onSelected: (value) {
                  controller.add(_filters[index]);
                  widget.onChange(controller.value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
