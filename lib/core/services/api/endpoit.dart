class Endpoint {
  static final String baseurl = "http://supermarket-dan1.onrender.com/api/v1/";
  static final String signIn = "auth/signIn";
  static final String signUp = "auth/signUp";
  static final String forgetwithemail = "auth/resetPassCode";
  static final String restPass = "auth/resetPassword";
  static final String codeRest = "auth/activeResetPass";
  static final String brands = "home/brands";
  static final String listBrands = "home/brands/names";
  static final String categories = "home/categories";
  static final String proudacts = "home/products";
  static final String addfavourite = "user/addFavorite";
  static final String getfavourite = "user/getFavorite";
  static final String delfavourite = "user/deleteFavorite";

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
// "name":"mohamed",
//     "phone":"01012345678",
//     "email":"mbassiony67@gmail.com",
//     "password":"Mohamed#1234",
//     "confirmPassword":"Mohamed#1234"String