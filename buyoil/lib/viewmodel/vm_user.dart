//
// import 'package:flutter/foundation.dart';
// import '../model/user_request.dart';
// import '../repository/user_repository.dart';
//
// class UserViewModel extends ChangeNotifier {
//   final UserRepository _repository;
//
//   UserViewModel(this._repository);
//
//   UserResult? _user;
//   bool _isLoading = false;
//   String? _error;
//
//   UserResult? get user => _user;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//
//   Future<void> fetchUser(String number) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     try {
//       if(number.length == 11) {
//         _user = await _repository.fetchUser(
//             phoneNumber: number,
//             rfid: "",
//         );
//       } else if(number.length == 10) {
//         _user = await _repository.fetchUser(
//           phoneNumber: "",
//           rfid: number,
//         );
//       } else {
//         _error = "Invalid input";
//       }
//     } catch(e) {
//       _error = e.toString();
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
// }