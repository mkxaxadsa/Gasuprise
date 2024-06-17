import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../data/models/eventModel/gift_model/gift_model.dart';
import '../../../widgets/custom_text_form_field.dart';

class GiftItem extends StatefulWidget {
  final int index;
  final Gift gift;

  GiftItem({key, required this.gift, required this.index});

  @override
  State<GiftItem> createState() => _GiftItemState();
}

class _GiftItemState extends State<GiftItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.v, horizontal: 12.h),
      decoration: AppDecoration.fillWhiteA
          .copyWith(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              'Gift ${widget.index + 1}',
              style: CustomTextStyles.titleMediumOnPrimary,
            ),
          ),
          SizedBox(
            height: 10.v,
          ),
          CustomTextFormField(
            hintText: 'Gift name',
            hintStyle: CustomTextStyles.titleMediumGray700,
            textStyle: CustomTextStyles.titleMediumOnPrimary,
            onChanged: (value) {
              setState(() {
                widget.gift.giftName = value;
              });
            },
          ),
          SizedBox(
            height: 10.v,
          ),
          CustomTextFormField(
            hintText: 'Price',
            textInputType: TextInputType.number,
            hintStyle: CustomTextStyles.titleMediumGray700,
            textStyle: CustomTextStyles.titleMediumOnPrimary,
            onChanged: (value) {
              setState(() {
                widget.gift.price = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ],
      ),
    );
  }
}
