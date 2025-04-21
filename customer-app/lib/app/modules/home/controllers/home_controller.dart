import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api/server.dart';
import '../../../data/model/body/place_order_body.dart';
import '../../../data/model/response/branch_model.dart';
import '../../../data/model/response/category_model.dart';
import '../../../data/model/response/item_model.dart';
import '../../../data/model/response/order_mode.dart';
import '../../../data/repository/branch_repo.dart';
import '../../../data/repository/category_repo.dart';
import '../../../data/repository/featured_item_repo.dart';
import '../../../data/repository/item_repo.dart';
import '../../../data/repository/my_order_repo.dart';
import '../../../data/repository/popular_item_repo.dart';

class HomeController extends GetxController {
  static Server server = Server();
  List<OrdersData> activeOrderData = <OrdersData>[];
  List<CategoryData> categoryDataList = <CategoryData>[];
  List<ItemData> itemDataList = <ItemData>[];
  final itemDetailsData = ItemData().obs;
  List<ItemData> popularItemDataList = <ItemData>[];
  List<ItemData> featuredItemDataList = <ItemData>[];
  List<BranchData> branchDataList = <BranchData>[];

  String? selectedBranch;
  int? selectedbranchId;

  bool loader = false;
  bool menuLoader = false;
  bool featuredLoader = false;
  bool offerLoader = false;
  bool popularLoader = false;
  bool activeOrderLoader = false;
  int selectedBranchIndex = 0;

  List<Variations> variationList = [];

  @override
  void onInit() {
    final box = GetStorage();
    getCategoryList();
    getBranchList();
    getPopularItemDataList();
    getFeaturedItemDataList();
    getItemDataList();
    if (box.read('isLogedIn') == true && box.read('isLogedIn') != null) {
      getActiveOrderList();
    }
    super.onInit();
  }

  setIndexOfBranch() {
    selectedBranchIndex =
        branchDataList.indexWhere((e) => e.name == selectedBranch);

    selectedbranchId = branchDataList[selectedBranchIndex].id!;
  }

  setSelectedBranchIndex(int index) {
    selectedBranchIndex = index;
    update();
  }

  getCategoryList() async {
    menuLoader = true;
    update();
    var categoryData = await CategoryRepo.getCategory();
    if (categoryData != null) {
      categoryDataList = categoryData.data!;
      menuLoader = false;
      update();
    } else {
      menuLoader = false;
      update();
    }
  }

  getBranchList() async {
    var branchData = await BranchRepo.getBranch();
    if (branchData.data != null) {
      branchDataList = branchData.data!;
      setInitialBranch();
      update();
    }
  }

  setInitialBranch() {
    if (selectedBranch == null) {
      selectedBranch = branchDataList[0].name;
      selectedbranchId = branchDataList[0].id!;
    }
  }

  getItemDataList() async {
    var itemData = await ItemRepo.getItem();
    if (itemData != null) {
      itemDataList = itemData.data!;
      update();
    } else {
      update();
    }
  }

  getItemDetails({required int itemID}) async {
    var itemData = await ItemRepo.getItemDetails(itemID: itemID);
    if (itemData != null) {
      itemDetailsData.value = itemData;
      variationList.clear();
      if (itemDetailsData.value.itemAttributes!.isNotEmpty) {
        for (var e in itemDetailsData.value.itemAttributes!) {
          variationList.add(
            (Variations(
              id: itemDetailsData.value.variations[e.id.toString()][0]['id'],
              itemAttributeId: int.parse(itemDetailsData
                  .value.variations[e.id.toString()][0]['item_attribute_id']
                  .toString()),
              name: itemDetailsData.value.variations[e.id.toString()][0]
                  ['name'],
              variationName: itemDetailsData.value.itemAttributes![0].name,
              price: double.parse(itemDetailsData
                  .value.variations[e.id.toString()][0]['convert_price']
                  .toString()),
            )),
          );
          print(variationList[0].price);
        }
      }

      update();
    } else {
      update();
    }
  }

  getPopularItemDataList() async {
    popularLoader = true;
    update();
    var popularItemData = await PopularItemRepo.getPopularItem();
    if (popularItemData != null) {
      popularItemDataList = popularItemData.data!;
      popularLoader = false;
      update();
    } else {
      update();
    }
  }

  getFeaturedItemDataList() async {
    featuredLoader = true;
    update();
    var featuredItemData = await FeaturedItemRepo.getFeaturedItem();
    if (featuredItemData != null) {
      featuredItemDataList = featuredItemData.data!;
      update();
      featuredLoader = false;
      update();
    } else {
      update();
    }
  }

  getActiveOrderList() async {
    var activeOrder = await MyOrderRepo.getActiveOrder();
    if (activeOrder != null) {
      activeOrderData = activeOrder.data!;
      update();
    } else {}
  }
}
