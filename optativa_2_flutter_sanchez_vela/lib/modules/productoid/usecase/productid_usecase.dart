import '../../../infrastructure/app/use_case/use_case.dart';
import '../domain/dto/productid_credentials.dart';
import '../domain/dto/productid_response.dart';
import '../domain/repository/productid_repository.dart';

class GetProductByIdUseCase implements UseCase<dynamic, ProductId> {
  final ProductRepository repository;

  GetProductByIdUseCase(this.repository);

  @override
  Future<dynamic> execute(ProductId params) async {
    final ProductResponse response = await repository.execute(params);
    return response;
  }
}
