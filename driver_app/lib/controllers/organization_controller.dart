import 'package:driver_app/api/utils.dart';
import 'package:driver_app/modals/organization.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  Future<List<Organization>> allOrg({required String token}) async {
    String url = '/api/common/allOrg';
    dynamic response = await getRequest(
      url: url,
      token: token,
    );
    return getAllOrgList(response);
  }

  List<Organization> getAllOrgList(Map<dynamic, dynamic> response) {
    List<Organization> orgList = [];
    if (response["error"] != true) {
      for (var item in response["body"]) {
        Organization org = Organization(id: item["id"], name: item["name"]);
        orgList.add(org);
      }
    }

    return orgList;
  }
}
