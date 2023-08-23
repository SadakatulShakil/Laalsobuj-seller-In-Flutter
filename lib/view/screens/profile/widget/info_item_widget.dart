import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class InfoItem extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? amount;
  final bool isMoney;
  const InfoItem({Key? key, this.icon, this.title, this.amount, this.isMoney = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.paddingSizeExtraSmall),
      child: Container(height: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          boxShadow: [BoxShadow(color: ColorResources.getPrimary(context).withOpacity(.05),
              spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: Dimensions.iconSizeExtraLarge,
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.iconSizeExtraLarge)
                ),
                child: Image.asset(icon!)),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
              child: !isMoney? Text(amount!,
                style: titilliumSemiBold.copyWith(color:  Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeLarge),):
              Text('${Provider.of<SplashProvider>(context, listen: false).myCurrency!.symbol} ${NumberFormat.compact().format(double.parse(amount!))}',
                style: titilliumSemiBold.copyWith(color:  Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeLarge),),
            ),




            Text(getTranslated(title, context)!,
              style: titilliumRegular.copyWith(color:  Theme.of(context).hintColor,
                  fontSize: Dimensions.fontSizeLarge),),
          ],),
      ),
    );
  }
}