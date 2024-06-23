import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pulse/core/utils/service_locator.dart';
import 'package:pulse/core/utils/styles.dart';
import 'package:pulse/core/widgets/custom_appbar.dart';
import 'package:pulse/generated/l10n.dart';

class UidView extends StatelessWidget {
  final dataController = Get.put(DataController());
  final TextEditingController _controller = TextEditingController();
  final String uid = getIt.get<FirebaseAuth>().currentUser!.uid;
  UidView({super.key});

  @override
  Widget build(BuildContext context) {
    dataController.getData(uid);
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).uidViewTitle,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                _controller.text = dataController.data.value;
                Clipboard.setData(ClipboardData(text: _controller.text));
                Get.snackbar(S.of(context).uidViewCopied,
                    S.of(context).uidViewTextCopiedToClipboard,
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Text(
                dataController.data.value,
                style: Styles.textStyleSemiBold16,
              ),
            ),
            Text(S.of(context).uidViewTapToCopy)
          ],
        ),
      ),
    );
  }
}

class DataController extends GetxController {
  var data = ''.obs;

  void getData(newData) {
    data.value = newData;
  }
}
