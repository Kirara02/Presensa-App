// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'appwrite_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appwriteClient)
const appwriteClientProvider = AppwriteClientProvider._();

final class AppwriteClientProvider
    extends $FunctionalProvider<Client, Client, Client>
    with $Provider<Client> {
  const AppwriteClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appwriteClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appwriteClientHash();

  @$internal
  @override
  $ProviderElement<Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Client create(Ref ref) {
    return appwriteClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Client>(value),
    );
  }
}

String _$appwriteClientHash() => r'1d0ad801dcbd77d0443dfc5e252d8530957ce331';

@ProviderFor(appwriteAccount)
const appwriteAccountProvider = AppwriteAccountProvider._();

final class AppwriteAccountProvider
    extends $FunctionalProvider<Account, Account, Account>
    with $Provider<Account> {
  const AppwriteAccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appwriteAccountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appwriteAccountHash();

  @$internal
  @override
  $ProviderElement<Account> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Account create(Ref ref) {
    return appwriteAccount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Account value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Account>(value),
    );
  }
}

String _$appwriteAccountHash() => r'7c5c3bf21a5f8cc29d2fbcff5337c6cfc39ff979';

@ProviderFor(appwriteTablesDB)
const appwriteTablesDBProvider = AppwriteTablesDBProvider._();

final class AppwriteTablesDBProvider
    extends $FunctionalProvider<TablesDB, TablesDB, TablesDB>
    with $Provider<TablesDB> {
  const AppwriteTablesDBProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appwriteTablesDBProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appwriteTablesDBHash();

  @$internal
  @override
  $ProviderElement<TablesDB> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TablesDB create(Ref ref) {
    return appwriteTablesDB(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TablesDB value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TablesDB>(value),
    );
  }
}

String _$appwriteTablesDBHash() => r'b83b810935302feecf022f5816f1eef937ed0175';

@ProviderFor(appwriteFunctions)
const appwriteFunctionsProvider = AppwriteFunctionsProvider._();

final class AppwriteFunctionsProvider
    extends $FunctionalProvider<Functions, Functions, Functions>
    with $Provider<Functions> {
  const AppwriteFunctionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appwriteFunctionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appwriteFunctionsHash();

  @$internal
  @override
  $ProviderElement<Functions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Functions create(Ref ref) {
    return appwriteFunctions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Functions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Functions>(value),
    );
  }
}

String _$appwriteFunctionsHash() => r'092cfb103b6c96f52da562909c80c2ee8569375a';
