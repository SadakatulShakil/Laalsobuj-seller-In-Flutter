import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/emergency_contact_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/emergency_contact_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';

class AddEmergencyContact extends StatefulWidget {
  final ContactList? contactList;
  final int? index;
  const AddEmergencyContact({Key? key,  this.index, this.contactList}) : super(key: key);

  @override
  State<AddEmergencyContact> createState() => _AddEmergencyContactState();
}

class _AddEmergencyContactState extends State<AddEmergencyContact> {

  TextEditingController contactNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();

  @override
  void initState() {
    if(widget.contactList != null){
      contactNameController.text = widget.contactList!.name!;
      phoneController.text = widget.contactList!.phone!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Consumer<EmergencyContactProvider>(
          builder: (context, emergencyContactProvider, _) {
            return Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [

                Container(
                    margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeSmall),
                    child: CustomTextField(
                      border: true,
                      hintText: getTranslated('contact_name', context),
                      focusNode: nameFocus,
                      nextNode: phoneFocus,
                      textInputType: TextInputType.name,
                      controller: contactNameController,
                      textInputAction: TextInputAction.next,
                    )),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeSmall),
                    child: CustomTextField(
                      border: true,
                      hintText: getTranslated('phone', context),
                      focusNode: phoneFocus,
                      isAmount: true,
                      textInputType: TextInputType.name,
                      controller: phoneController,
                      textInputAction: TextInputAction.next,
                    )),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                  child: emergencyContactProvider.isLoading? const CircularProgressIndicator():
                  CustomButton(btnTxt: widget.contactList != null?  getTranslated('update', context) : getTranslated('add', context),
                  onTap: (){
                    int? id = widget.contactList != null?  widget.contactList!.id : null;
                    String name = contactNameController.text.trim();
                    String phone = phoneController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar(getTranslated('contact_name_is_required', context), context);
                    }
                    else if(phone.isEmpty){
                      showCustomSnackBar(getTranslated('phone_is_required', context), context);
                    }else{
                      emergencyContactProvider.addNewEmergencyContact(context, name, phone, id, isUpdate: widget.contactList != null);
                    }

                  },),
                )
              ],),
            );
          }
        ));
  }
}
