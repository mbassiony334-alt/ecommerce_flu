class Endpoint {
  static final String baseUrl = "https://supermarket-dan1.onrender.com/api/v1/";
  static final String signIn = "auth/signIn";
  static final String signUp = "auth/signUp";
  static final String forgetWithEmail = "auth/resetPassCode";
  static final String resetPassword = "auth/resetPassword";
  static final String codeReset = "auth/activeResetPass";
  static final String brands = "home/brands";
  static final String listBrands = "home/brands/names";
  static final String categories = "home/categories";
  static final String products = "home/products?skip=0&limit=10";
  static final String addFavourite = "user/addFavorite";
  static final String getFavourite = "user/getFavorite";
  static final String delFavourite = "user/deleteFavorite";
  static final String addCart = "user/addCart";
  static final String getCart = "user/getCartt";
  static final String delCart = "user/deleteCart";
}

class ApiKey {
  static String token = "token";
  static String errorMessage = "message";
  static String status = "status";
  static String email = "email";
  static String password = "password";
  static String confirmPassword = "confirmPassword";
  static String name = "name";
  static String phone = "phone";
  static String productId = "productId";
}

