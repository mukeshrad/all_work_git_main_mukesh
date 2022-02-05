import 'package:swagger/api.dart';

final apiClient = ApiClient();

final transactionInstance = TransactionsApi(apiClient);

final userApi = UsersApi(apiClient);

CardsApi cardsApi = CardsApi(apiClient);

