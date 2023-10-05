import '../../../../core/adapters/http/http_adapter.dart';
import '../../../../core/adapters/network/network_adapter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/coordinates_model.dart';

const _apiUrlPart = '/json';
const _apiQueryParamsKey = 'fields';
const _apiQueryParamsValue = 'lat,lon';

///
abstract class LocationApiDataSource {
  /// Get Coordinates via API.
  ///
  /// Throws a [ServerException] or [NetworkException].
  Future<CoordinatesModel> getCoordinates();
}

///
class LocationApiDataSourceImpl implements LocationApiDataSource {
  ///
  const LocationApiDataSourceImpl({
    required this.networkAdapter,
    required this.httpAdapter,
  });

  ///
  final NetworkAdapter networkAdapter;

  ///
  final HttpAdapter httpAdapter;

  @override
  Future<CoordinatesModel> getCoordinates() => _getCoordinates();

  Future<CoordinatesModel> _getCoordinates() async {
    if (await networkAdapter.isConnected) {
      final response = await httpAdapter.get<ResponseMapType>(
        _apiUrlPart,
        queryParameters: {_apiQueryParamsKey: _apiQueryParamsValue},
      );

      if (response.statusCode == 200) {
        return CoordinatesModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } else {
      throw NetworkException();
    }
  }
}
