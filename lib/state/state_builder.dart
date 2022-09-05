// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'inherited_widget.dart';

class StateChange<T> extends StatelessWidget {
  StateChange({
    Key? key,
    this.debugW,
    required this.notifier,
    required this.builder,
  }) : super(key: key ?? UniqueKey());

  final DebugW? debugW;
  final ValueNotifier<T> notifier;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      if (debugW?.key == true) {
        print(context.widget.key.toString());
      }
    }
    return InheritedWidgetValueNotifier(
      notifier: notifier,
      child: Builder(
        builder: (context) {
          if (kDebugMode) {
            if (debugW?.value == true) {
              print(InheritedWidgetValueNotifier.of<T>(context).value);
            }
          }
          return builder(
            context,
            InheritedWidgetValueNotifier.of<T>(context).value,
          );
        },
      ),
    );
  }
}

class DebugW {
  final bool key;

  final bool value;
  DebugW({
    this.key = false,
    this.value = false,
  });
}
