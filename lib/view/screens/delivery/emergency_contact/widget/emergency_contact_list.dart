import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/emergency_contact_model.dart';
import 'package:sixvalley_vendor_app/provider/emergency_contact_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_loader.dart';
import 'package:sixvalley_vendor_app/view/base/no_data_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/emergency_contact/widget/emergency_contact_card.dart';



class EmergencyContactListView extends StatelessWidget {
  const EmergencyContactListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EmergencyContactProvider>(
      builder: (context, emergencyContactProvider, child) {
        List<ContactList> contactList;
        contactList = emergencyContactProvider.contactList;


        return Column(mainAxisSize: MainAxisSize.min, children: [
          !emergencyContactProvider.isLoading ? contactList.isNotEmpty ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeSmall),
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return EmergencyContactCardWidget(contactList: contactList[index], index: index);
              },
            ),
          ): Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
            child: const NoDataScreen(),
          ) :Container(transform: Matrix4.translationValues(0, -MediaQuery.of(context).size.height/2.5, 0),
              child: const CustomLoader()),

          emergencyContactProvider.isLoading ? Center(child: Padding(
            padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          )) : const SizedBox.shrink(),

        ]);
      },
    );
  }
}
