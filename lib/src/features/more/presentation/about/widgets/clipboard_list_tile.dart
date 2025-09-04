import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:presensa_app/src/utils/toast/toast.dart';

class ClipboardListTile extends ConsumerWidget {
  const ClipboardListTile({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String? value;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(title),
      subtitle: value.isNotBlank ? Text(value!) : null,
      onTap:
          value.isNotBlank
              ? () {
                final toast = ref.read(toastProvider(context));
                final msg = "$title: $value";
                Clipboard.setData(ClipboardData(text: msg));

                toast.instantShow(
                  context.l10n!.copy_msg(msg),
                  // withPositioned: true,
                );
              }
              : null,
    );
  }
}
