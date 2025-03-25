class ConstRes {
  /// api url
  // static const String baseUrl = 'http://192.168.0.116/cutfx_backend/api/';
  // static const String itemBaseUrl =
  //     'http://192.168.0.116/cutfx_backend/public/storage/';
  //
  static const String baseUrl = 'https://qaychi.com/api/';
  static const String itemBaseUrl = 'https://qaychi.com/public/storage/';
  static String termsOfUseUrl = baseUrl.replaceAll('api/', 'termsOfUse');
  static String privacyPolicyUrl = baseUrl.replaceAll('api/', 'privacypolicy');
  static const String registerUser = '${baseUrl}user/registerUser';
  static const String fetchHomePageData = '${baseUrl}user/fetchHomePageData';
  static const String fetchFavoriteData = '${baseUrl}user/fetchFavoriteData';
  static const String editUserDetails = '${baseUrl}user/editUserDetails';
  static const String fetchSalonDetails = '${baseUrl}user/fetchSalonDetails';
  static const String fetchSalonReviews = '${baseUrl}user/fetchSalonReviews';
  static const String salonAndServiceByCategory =
      '${baseUrl}user/salonAndServiceByCategory';
  static const String fetchService = '${baseUrl}user/fetchService';
  static const String fetchCoupons = '${baseUrl}user/fetchCoupons';
  static const String pushNotificationToSingleUser =
      '${baseUrl}pushNotificationToSingleUser';
  static const String fetchGlobalSettings = '${baseUrl}fetchGlobalSettings';
  static const String fetchUserDetails = '${baseUrl}user/fetchUserDetails';
  static const String addMoneyToUserWallet =
      '${baseUrl}user/addMoneyToUserWallet';
  static const String placeBooking = '${baseUrl}user/placeBooking';
  static const String fetchUserUpcomingBookings =
      '${baseUrl}user/fetchUserUpcomingBookings';
  static const String fetchUserBookings = '${baseUrl}user/fetchUserBookings';
  static const String cancelBooking = '${baseUrl}user/cancelBooking';
  static const String fetchBookingDetails =
      '${baseUrl}user/fetchBookingDetails';
  static const String addRating = '${baseUrl}user/addRating';
  static const String rescheduleBooking = '${baseUrl}user/rescheduleBooking';
  static const String uploadFileGivePath = '${baseUrl}uploadFileGivePath';
  static const String fetchAvailableSlotsOfStaff =
      '${baseUrl}user/fetchAvailableSlotsOfStaff';
  static const String fetchWalletStatement =
      '${baseUrl}user/fetchWalletStatement';
  static const String submitUserWithdrawRequest =
      '${baseUrl}user/submitUserWithdrawRequest';
  static const String fetchSalonByCoordinates =
      '${baseUrl}user/fetchSalonByCoordinates';
  static const String fetchSalonCategories = '${baseUrl}fetchSalonCategories';
  static const String fetchFaqCats = '${baseUrl}fetchFaqCats';
  static const String deleteMyUserAccount =
      '${baseUrl}user/deleteMyUserAccount';
  static const String searchSalon = '${baseUrl}user/searchSalon';
  static const String searchServices = '${baseUrl}user/searchServices';
  static const String searchTopRatedSalonsOfCategory =
      '${baseUrl}user/searchTopRatedSalonsOfCategory';
  static const String searchServicesOfCategory =
      '${baseUrl}user/searchServicesOfCategory';
  static const String fetchUserNotification =
      '${baseUrl}user/fetchNotification';
  static const String fetchUserWithdrawRequests =
      '${baseUrl}user/fetchUserWithdrawRequests';
  static const String fetchAcceptedPendingBookingsOfSalonByDate =
      '${baseUrl}user/fetchAcceptedPendingBookingsOfSalonByDate';
  static const String fetchAllStaffOfSalon = '${baseUrl}fetchAllStaffOfSalon';
  static const String addUserAddress = '${baseUrl}user/addUserAddress';
  static const String editUserAddress = '${baseUrl}user/editUserAddress';
  static const String deleteUserAddress = '${baseUrl}user/deleteUserAddress';
  static const String fetchMyAddress = '${baseUrl}user/fetchMyAddress';

  ///Api Key
  static const String apiKey = 'apikey';
  static const String apiKeyValue = '123';
  static const String userId = 'user_id';

  /// Api body keyword
  static const String email = 'email';
  static const String identity = 'identity';
  static const String fullname = 'fullname';
  static const String phoneNumber = 'phone_number';
  static const String isNotification = 'is_notification';
  static const String favouriteSalons = 'favourite_salons';
  static const String favouriteServices = 'favourite_services';
  static const String profileImage = 'profile_image';
  static const String salonName = 'salon_name';
  static const String ownerPhoto = 'owner_photo';
  static const String ownerName = 'owner_name';
  static const String type = 'type';
  static const String loginType = 'login_type';
  static const String deviceToken = 'device_token';
  static const String deviceType = 'device_type';
  static const String salonId_ = 'salon_id';
  static const String serviceId = 'service_id';
  static const String bookingId = 'booking_id';
  static const String salonAbout = 'salon_about';
  static const String salonAddress = 'salon_address';
  static const String salonPhone = 'salon_phone';
  static const String salonLat = 'salon_lat';
  static const String salonLong = 'salon_long';
  static const String lat = 'lat';
  static const String long = 'long';
  static const String km = 'km';
  static const String monFriFrom = 'mon_fri_from';
  static const String monFriTo = 'mon_fri_to';
  static const String satSunFrom = 'sat_sun_from';
  static const String satSunTo = 'sat_sun_to';
  static const String genderServed = 'gender_served';
  static const String salonCategories = 'salon_categories';
  static const String images_ = 'images[]';
  static const String deleteImageIds_ = 'deleteImageIds[]';
  static const String bankTitle = 'bank_title';
  static const String accountNumber = 'account_number';
  static const String holder = 'holder';
  static const String swiftCode = 'swift_code';
  static const String chequePhoto = 'cheque_photo';
  static const String categoryId = 'category_id';
  static const String title = 'title';
  static const String price = 'price';
  static const String discount = 'discount';
  static const String gender = 'gender';
  static const String about = 'about';
  static const String serviceTime = 'service_time';
  static const String status = 'status';
  static const String awardBy = 'award_by';
  static const String description = 'description';
  static const String awardId = 'award_id';
  static const String galleryId = 'gallery_id';
  static const String image = 'image';
  static const String start = 'start';
  static const String count = 'count';
  static const String date = 'date';
  static const String month = 'month';
  static const String year = 'year';
  static const String salonData = 'salonData';
  static const String gallery = 'gallery';
  static const String services = 'services';
  static const String salon = 'salon';
  static const String time = 'time';
  static const String amount = 'amount';
  static const String gateway = 'gateway';
  static const String transactionSummary = 'transaction_summary';
  static var staffData = "staff_data";
  static const String transactionId = 'transaction_id';
  static const String duration = 'duration';
  static const String payableAmount = 'payable_amount';
  static const String isCouponApplied = 'is_coupon_applied';
  static const String couponTitle = 'coupon_title';
  static const String couponId = 'coupon_id';
  static const String discountAmount = 'discount_amount';
  static const String serviceAmount = 'service_amount';
  static const String subtotal = 'subtotal';
  static const String staffId = 'staff_id';
  static const String serviceLocation = 'service_location';
  static const String totalTaxAmount = 'total_tax_amount';
  static const String paymentType = 'payment_type';
  static const String rating = 'rating';
  static const String comment = 'comment';
  static const String file = 'file';
  static const String senderId = 'sender_id';
  static const String notificationType = 'notification_type';
  static const String password = 'password';
  static const String keyword = 'keyword';
  static const String languageCode = 'languageCode';
  static const String name = 'name';
  static const String mobile = 'mobile';
  static const String address = 'address';
  static const String addressId = 'address_id';
  static const String locality = 'locality';
  static const String city = 'city';
  static const String pin = 'pin';
  static const String country = 'country';
  static const String state = 'state';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';

  static const int count_ = 10;
  static const String aPost = 'POST';

  static const String isLogin = 'is_login';

  static int userIdValue = -1;

  static var authorisationKey = '----------------';

  static var weekday = 'weekday';
}
