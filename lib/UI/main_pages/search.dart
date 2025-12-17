part of "../../homescout_library.dart";

double defaultLatitude = -1.286389;
double defaultLongitude = 36.8219;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<bool> _isToggled = [true, false];

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PropertiesViewModel viewModel = Provider.of<PropertiesViewModel>(context);

    double longitude = viewModel.locationData?.longitude ?? defaultLongitude;
    double latitude = viewModel.locationData?.latitude ?? defaultLatitude;

    Widget searchField = PlainTextField(
      controller: searchController,
      hint: Text('Search Properties'),
      onChanged: (value) {
        viewModel.search(value);
      },
    );

    Widget toggleButtons = ToggleButtons(
      borderRadius: BorderRadius.circular(radiusValue),
      isSelected: _isToggled,
      onPressed: (index) async {
        setState(() {
          if (index == 0) {
            _isToggled[0] = true;
            _isToggled[1] = false;
          } else {
            _isToggled[0] = false;
            _isToggled[1] = true;
          }
        });
        viewModel.locationData = await getCurrentLocation();
      },
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingValue),
          child: Icon(listIcon),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingValue),
          child: Icon(mapsIcon),
        ),
      ],
    );

    List<Widget> listItems = [];

    for (var property in viewModel.displayedSearchProperties) {
      listItems.add(
        searchPageCard(
          viewmodel: viewModel,
          property: property,
          onTap: () {
            navigate(
              path: detailPath,
              extra: viewModel.displayedSearchProperties.indexOf(property),
            );
          },
          context: context,
          onLiked: () {
            Property updated = property.copyWith(liked: !property.liked);
            viewModel.updateProperty(updated);
          },
        ),
      );
    }

    final double systemBottomInset = MediaQuery.of(context).padding.bottom;

    final double totalBottomPadding =
        kBottomNavigationBarHeight + systemBottomInset;

    Widget propertiesListView = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: totalBottomPadding),
        child: Column(children: listItems),
      ),
    );

    Widget propertiesList =  listItems.isEmpty
          ? Center(child: Text("No Results", style: context.titleMedium))
          : propertiesListView;

    Set<Marker> markers = {};

    for (var property in viewModel.displayedSearchProperties) {
      markers.add(
        Marker(
          markerId: MarkerId(property.id),
          position: LatLng(property.lat, property.lng),
          onTap: () {},
        ),
      );
    }

    Widget mapScreen = CustomMap(
      key: const ValueKey("main-map"),
      initLongitude: longitude,
      initLatitude: latitude,
      markers: markers,
      onMapCreated: (controller) {
        if (viewModel.displayedSearchProperties.isEmpty) {
          updatePosition(latitude, longitude, controller);
        } else {
          log("${viewModel.displayedSearchProperties[0].lat} lat");
          updatePosition(
            viewModel.displayedSearchProperties[0].lat,
            viewModel.displayedSearchProperties[0].lng,
            controller,
          );
        }
      },
    );

    Widget body = Expanded(
      child: IndexedStack(
        index: _isToggled[0] ? 0 : 1,
        children: [propertiesList, mapScreen],
      ),
    );

    return SpacedColumn(
      padding: 0,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        topSpacer(context),
        Padding(padding: paddingValueHorizontal, child: searchField),
        Padding(
          padding: paddingValueHorizontal,
          child: Divider(color: context.tintedBackgroundColor),
        ),
        Padding(
          padding: paddingValueHorizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              listItems.isEmpty
                  ? Text("")
                  : FadedText(
                      searchController.text.isNotEmpty
                          ? "${listItems.length} Properties Found"
                          : "Recommended For You",
                    ),
              toggleButtons,
            ],
          ),
        ),
        body,
      ],
    );
  }
}
