import 'package:swagger/api.dart';

final apiClient = ApiClient();

final transactionApi = TransactionsApi(apiClient);

final userApi = UsersApi(apiClient);

final documentsApi = DocumentsApi(apiClient);

final cardsApi = CardsApi(apiClient);

final aadharVerificationApi = AadharVerificationApi(apiClient);

final merchantApi = MerchantsApi(apiClient);

final goldenTicketApi = GoldenTicketsApi(apiClient);

final billApi = BillsApi(apiClient);
