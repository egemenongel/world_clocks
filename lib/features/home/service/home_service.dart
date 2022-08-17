import 'package:world_clocks/core/constants/api_constants.dart';
import 'package:world_clocks/core/constants/enums/request_types.dart';
import 'package:world_clocks/core/utils/network/network_manager.dart';

class HomeService {
  final NetworkManager? _networkManager = NetworkManager.instance;

  Future<List?> fetchTimezoneAreas() async {
    return await _networkManager!.primitiveRequest(
        method: RequestTypes.get, path: ApiConstants.timezone);
  }
}
