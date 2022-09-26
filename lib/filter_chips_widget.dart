import 'package:flutter/material.dart';

import 'filter_chips_controller.dart';
import 'multi_value_listenable_builder.dart';

class FilterChipsWidget extends StatefulWidget {
  const FilterChipsWidget(
    this.height, {
    super.key,
    this.alignment = Alignment.center,
    required this.filters,
    required this.onChange,
    this.padding,
    this.margin,
  });
  final void Function(List<String> data) onChange;
  final List<String> filters;
  final double height;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  State<FilterChipsWidget> createState() => _FilterChipsWidgetState();
}

class _FilterChipsWidgetState extends State<FilterChipsWidget>
    with AutomaticKeepAliveClientMixin {
  late final List<String> _filters;

  final FilterChipsController controller = FilterChipsController();

  @override
  void initState() {
    _filters = [...widget.filters];

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _filters.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      height: widget.height,
      alignment: widget.alignment,
      child: MultiValueListenableBuilder(
        valueListenables: [
          controller,
        ],
        builder: (context, values, child) {
          final List<String> lista = values.elementAt(0) as List<String>;
          return Wrap(
            spacing: 2,
            children: [
              ...List.generate(
                _filters.length,
                (index) {
                  final String filter = _filters[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                    ),
                    child: InkWell(
                      onLongPress: null,
                      child: FilterChip(
                        key: ObjectKey(filter),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.transparent,
                            width: 0,
                            strokeAlign: StrokeAlign.outside,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        side: const BorderSide(width: 0),
                        label: Text(
                          filter,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        selected: lista.contains(filter),
                        onSelected: (value) {
                          controller.add(filter);
                          widget.onChange(controller.value);
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
