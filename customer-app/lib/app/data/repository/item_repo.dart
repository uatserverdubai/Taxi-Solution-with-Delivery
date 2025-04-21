// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/item_model.dart';

class ItemRepo {
  static Server server = Server();
  static ItemModel itemModel = ItemModel();
  static ItemData itemModelDetails = ItemData();

  static Future<ItemModel?> getItem() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.itemList! + "?status=5",
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          itemModel = ItemModel.fromJson(jsonResponse);
          return itemModel;
        }
      });
      return itemModel;
    } catch (e) {
      return null;
    }
  }

  static Future<ItemData?> getItemDetails({required int itemID}) async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.itemDetails! + itemID.toString(),
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          itemModelDetails = ItemData.fromJson(jsonResponse['data']);
          return itemModelDetails;
        }
      });
      return itemModelDetails;
    } catch (e) {
      return null;
    }
  }
}
