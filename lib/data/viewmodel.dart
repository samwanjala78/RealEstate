part of "../../homescout_library.dart";

class PropertiesViewModel extends ChangeNotifier {
  String? userId;
  LocationData? locationData;

  XFile? _profilePic;
  int propertyCount = 0;
  LocalUser? _currentUser;

  List<Chat> chats = [];
  List<Message> messages = [];
  List<String> locations = [];
  List<Property> _properties = [];
  List<Property> _likedProperties = [];
  List<Property> displayedSearchProperties = [];

  XFile? get profilePic => _profilePic;
  LocalUser? get currentUser => _currentUser;
  List<Property> get properties => _properties;
  List<Property> get likedProperties => _likedProperties;

  Future<void> initApp() async {
    await getCount();
    await getProperties();
    fetchPopular();
    await fetchSavedProperties();
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    log("startup userId: $userId");
    if (userId != null) {
      await fetchAccount(userId: userId!);
    }
    fetchChats();
    notifyListeners();
  }

  Property uploadProperty = Property(
    features: [],
    imageUrls: [],
    liked: false,
    title: "",
    location: "",
    price: "",
    rating: 4.5,
    bedrooms: "5",
    bathrooms: "5",
    area: "area",
    type: PropertyType.forRent.type,
    views: 0,
    contactEmail: "william.henry.harrison@example-pet-store.com",
    contactNumber: "0712345678",
    contactName: "John Doe",
    lat: 0,
    lng: 0,
  );

  void disposeProperty() {
    uploadProperty = Property(
      features: [],
      imageUrls: [],
      liked: false,
      title: "",
      location: "",
      price: "",
      rating: 0,
      bedrooms: "",
      bathrooms: "",
      area: "area",
      type: PropertyType.forRent.type,
      views: 0,
      contactEmail: "william.henry.harrison@example-pet-store.com",
      contactNumber: "0712345678",
      contactName: "John Doe",
      lat: 0,
      lng: 0,
    );
  }

  set currentUser(LocalUser? value) {
    _currentUser = value;
    notifyListeners();
  }

  set profilePic(XFile? value) {
    _profilePic = value;
    notifyListeners();
  }

  Future<void> getProperties() async {
    log("fetching properties");
    _properties = await NetworkLayer.getProperties();
    sortProperties(SortOptions.rating);
    fetchPopular();
  }

  void sortProperties(SortOptions sortOption) {
    switch (sortOption) {
      case SortOptions.priceLow:
        _properties.sort(
          (a, b) => a.price.convertPriceToInt().compareTo(
            b.price.convertPriceToInt(),
          ),
        );
        notifyListeners();
        break;
      case SortOptions.priceHigh:
        _properties.sort(
          (a, b) => b.price.convertPriceToInt().compareTo(
            a.price.convertPriceToInt(),
          ),
        );
        notifyListeners();
        break;
      case SortOptions.rating:
        _properties.sort((a, b) => b.rating.compareTo(a.rating));
        notifyListeners();
    }
  }

  Future<LocalUser?> getUserViaEmail(String email) {
    return NetworkLayer.getUserByEmail(email);
  }

  Future<void> getCount() async {
    propertyCount = await NetworkLayer.getCount();
  }

  void fetchPopular() {
    List<String> popularLocations = const [
      "Westlands",
      "Embakasi",
      "Donholm",
      "Kinoo",
      "Kikuyu",
    ];
    displayedSearchProperties = _properties.where((place) {
      return popularLocations.any(
        (popular) =>
            place.location.toLowerCase().contains(popular.toLowerCase()),
      );
    }).toList();
    log("displayedSearchProperties ${displayedSearchProperties.length}");
  }

  Future<void> fetchAccount({required String userId}) async {
    _currentUser = await NetworkLayer.fetchAccount(userId);
  }

  Future<void> fetchChats() async {
    chats = await getChats();
  }

  Future<void> fetchMessages(String chatId) async {
    messages = await getMessages(chatId);
    notifyListeners();
  }

  Future<void> search(String query) async {
    log("fetching properties");
    displayedSearchProperties = await NetworkLayer.searchProperties(query);
    notifyListeners();
  }

  Future<void> fetchSavedProperties() async {
    _likedProperties = await NetworkLayer.queryProperties(
      NetworkLayer.savedPropertyQuery,
    );
  }

  Future<LocalUser?> updateUser(LocalUser user) async {
    return await NetworkLayer.updateUser(user);
  }

  Future<void> validateView({
    required String userId,
    required String propertyId,
  }) async {
    await NetworkLayer.validateView(userId: userId, propertyId: propertyId);
    notifyListeners();
  }

  Future<Property?> updateProperty(Property property) async {
    return await NetworkLayer.updateProperty(property);
  }

  Future<void> filterProperties(bool Function(Property) test) async {
    await getProperties();
    _properties = _properties.where((property) => test(property)).toList();
    notifyListeners();
  }

  Future<void> createProperty() async {
    await NetworkLayer.createProperty(uploadProperty);
    await getProperties();
    notifyListeners();
  }

  Future<void> resetProperties() async {
    await getProperties();
    notifyListeners();
  }
}
