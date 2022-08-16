import 'package:world_clocks/core/constants/api_constants.dart';
import 'package:world_clocks/core/utils/network/network_manager.dart';

class HomeService {
  final NetworkManager? _networkManager = NetworkManager.instance;

  Future<List<String>> fetchTimezoneAreas() async {
    return await _networkManager!.primitiveRequest(path: ApiConstants.timezone);
  }
}
