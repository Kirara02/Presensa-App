import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/logger/logger.dart';

/// Useful to log state change in our application
/// Read the logs and you'll better understand what's going on under the hood
base class ProviderStateLogger extends ProviderObserver {
  const ProviderStateLogger();
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    logger.d('''
        {
          provider: ${context.provider.name ?? context.provider.runtimeType},
          oldValue: $previousValue,
          newValue: $newValue
        }''');
    super.didUpdateProvider(context, previousValue, newValue);
  }
}
