// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:domain/models/server_info.dart' as _i4;
import 'package:flutter/material.dart' as _i3;
import 'package:server_info/server_info_screen.dart' as _i1;

abstract class $ServerInfoModule extends _i2.AutoRouterModule {
  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    ServerInfoRoute.name: (routeData) {
      final args = routeData.argsAs<ServerInfoRouteArgs>();
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ServerInfoScreen(
          key: args.key,
          selectedServer: args.selectedServer,
        ),
      );
    }
  };
}

/// generated route for
/// [_i1.ServerInfoScreen]
class ServerInfoRoute extends _i2.PageRouteInfo<ServerInfoRouteArgs> {
  ServerInfoRoute({
    _i3.Key? key,
    required _i4.ServerInfo selectedServer,
    List<_i2.PageRouteInfo>? children,
  }) : super(
          ServerInfoRoute.name,
          args: ServerInfoRouteArgs(
            key: key,
            selectedServer: selectedServer,
          ),
          initialChildren: children,
        );

  static const String name = 'ServerInfoRoute';

  static const _i2.PageInfo<ServerInfoRouteArgs> page =
      _i2.PageInfo<ServerInfoRouteArgs>(name);
}

class ServerInfoRouteArgs {
  const ServerInfoRouteArgs({
    this.key,
    required this.selectedServer,
  });

  final _i3.Key? key;

  final _i4.ServerInfo selectedServer;

  @override
  String toString() {
    return 'ServerInfoRouteArgs{key: $key, selectedServer: $selectedServer}';
  }
}
