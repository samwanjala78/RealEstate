//all imports for the app are here
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:bcrypt/bcrypt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart' hide LatLng;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_intl_phone_field/countries.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location/location.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' hide PermissionStatus;
import 'package:provider/provider.dart';
import 'package:real_estate/gen/assets.gen.dart';
import 'package:real_estate/models/models.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

part 'main.dart';
part 'util/util.dart';
part 'UI/ui.dart';

part 'UI/upload/basic_information.dart';
part 'UI/upload/contact_information.dart';
part 'UI/upload/property_features.dart';
part 'UI/upload/search_location.dart';
part 'UI/upload/upload_flow.dart';
part 'UI/upload/upload_photos.dart';

part 'UI/onboarding/landing_page_ui_elements.dart';
part 'UI/onboarding/landing_page.dart';
part 'UI/onboarding/profile_setup.dart';
part 'UI/onboarding/reset_password_email.dart';
part 'UI/onboarding/reset_password.dart';

part 'UI/main_pages/chats.dart';
part 'UI/main_pages/chat.dart';
part 'UI/main_pages/detail.dart';
part 'UI/main_pages/home.dart';
part 'UI/main_pages/profile.dart';
part 'UI/main_pages/saved.dart';
part 'UI/main_pages/search.dart';

part "network/network_util.dart";
part "network/messaging.dart";

part "data/viewmodel.dart";

part "constants/ui_constants.dart";

//list for whether a feature is selected during upload
List<bool> isFeatureSelected = List.generate(
  Feature.values.length,
  (_) => false,
);

