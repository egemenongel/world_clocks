import 'package:world_clocks/core/constants/api_constants.dart';
import 'package:world_clocks/core/constants/enums/request_types.dart';
import 'package:world_clocks/core/utils/network/network_manager.dart';
import 'package:world_clocks/features/timezone_detail/model/timezone_model.dart';

class TimezoneService {
  final NetworkManager? _networkManager = NetworkManager.instance;

  Future fetchTimezone(String timezone) async {
    return await _networkManager!.request(
      method: RequestTypes.get,
      path: ApiConstants.selectedTimezone(timezone),
      model: TimezoneModel(),
    );
  }
}
