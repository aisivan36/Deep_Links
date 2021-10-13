import 'package:flutter/material.dart';
import 'app_link.dart';

/// [AppRouteParser] extends [RouteInformationParser],
/// notice that takes a generic type. In this case our type is AppLink
/// which holds all of the route and navigation information
class AppRouteParser extends RouteInformationParser<AppLink> {
  /// The first method you need to override is [parseRouteInformation()]
  /// The route information contains the URL string
  @override
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    /// Take the route information and build an instance of [AppLink] from it
    final link = AppLink.fromLocation(routeInformation.location);
    return link;
  }

  /// Fixes
  @override
  RouteInformation restoreRouteInformation(AppLink appLink) {
    ///This function passes in an [AppLink] object. We ask [AppLink] to give us
    ///back the URL string
    final location = appLink.toLocation();

    /// Wrap it in the [RouteInformation] to pass it along
    return RouteInformation(location: location);
  }
}
