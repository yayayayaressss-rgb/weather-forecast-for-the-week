import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkCheckerServ {
  final InternetConnectionChecker serv;

  NetworkCheckerServ({required this.serv});

  Future<bool> checking() async {
    return serv.hasConnection;
  }
}
