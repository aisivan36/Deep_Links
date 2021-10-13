class AppLink {
  /// constant for each of URL
  static const String kHomePath = '/home';
  static const String kOnboardingPath = '/onboarding';
  static const String kLoginPath = '/login';
  static const String kProfilePath = '/profile';
  static const String kItemPath = '/item';

  /// constant for each query message
  static const String kTabParam = 'tab';
  static const String kIdParam = 'id';

  /// Stores the path of the URL using location
  String? location;

  /// Use currentTab to store the tab you want to redirect the user to
  int? currentTab;

  /// Stores the ID of the item you want to view in itemId
  String? itemId;

  AppLink({
    this.location,
    this.currentTab,
    this.itemId,
  });

  static AppLink fromLocation(String? location) {
    /// Decode the URL which often include [special] [characters] in their paths
    /// so we need to [percent-encode] the URL path. For example, we'd encode
    /// [hello!world] to [hello%21world]
    location = Uri.decodeFull(location ?? '');

    /// Parse the [URI] for query parameter keys and key-value pairs
    final uri = Uri.parse(location);
    final params = uri.queryParameters;

    /// Extract the [currentTab] from the [URL] path if it exist
    final currentTab = int.tryParse(params[AppLink.kTabParam] ?? '');

    /// Extract the [itemId] from the [URL] path if it exist
    final itemId = params[AppLink.kIdParam];

    /// Create the [AppLink] by passing in the query parameters you extract
    /// from the [URL] string
    final link = AppLink(
      location: uri.path,
      currentTab: currentTab,
      itemId: itemId,
    );

    /// Return the instance of [AppLink]
    return link;
  }

  String toLocation() {
    /// Create an internal function that formats the query parameter key-value
    /// pair into a string format
    String addKeyValPair({
      required String key,
      String? value,
    }) {
      return value == null ? '' : '${key}=$value&';
    }
    // end of function

    /// Go through each defined path
    switch (location) {
      //if the path is kLoginPath, return the right string path /login
      case kLoginPath:
        return kLoginPath;
      //If the path is kOnboardingPath, return the right string path: /onboarding.
      case kOnboardingPath:
        return kOnboardingPath;
      //If the path is kProfilePath, return the right string path: /profile.
      case kProfilePath:
        return kProfilePath;

      /// If the path is kItemPath, return the right string path: /item, and if there are any parameters, append ?id=${id}.
      case kItemPath:
        var loc = '$kItemPath?';
        loc += addKeyValPair(
          key: kIdParam,
          value: itemId,
        );
        return Uri.encodeFull(loc);

      /// If the path is invalid, default to the path /home. If the user selected a tab, append ?tab=${tabIndex}.
      default:
        var loc = '$kHomePath?';
        loc += addKeyValPair(
          key: kTabParam,
          value: currentTab.toString(),
        );
        return Uri.encodeFull(loc);
    }
  }
}
