import 'package:swagger/api.dart';

final apiClient = ApiClient();

final transactionInstance = TransactionsApi(apiClient);

final userApi = UsersApi(apiClient);

final cardsApi = CardsApi(apiClient);

final aadharVerificationApi = AadharVerificationApi(apiClient);