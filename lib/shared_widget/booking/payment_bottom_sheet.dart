import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/logger.dart';
import 'package:pay/pay.dart';

enum PaymentType { apple, google }

class PaymentBottomSheetsUtil {
  Future moneyConversionBottomSheet({
    required BuildContext context,
    required double totalAmount,
    required String mentorCurrency,
    required double dollerEquvilant,
    required Function(double) onSelectionDone,
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      enableDrag: true,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
          child: Wrap(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const Expanded(child: SizedBox()),
                  CustomText(
                    title: AppLocalizations.of(context)!.moneyconversion,
                    textColor: const Color(0xff444444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              mainConverterView(
                context: context,
                totalAmount: totalAmount,
                mentorCurrency: mentorCurrency,
                dollerEquvilant: dollerEquvilant,
                openNext: (newValue) {
                  Navigator.pop(context);
                  onSelectionDone(newValue);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future paymentBottomSheet({
    required BuildContext context,
    required double totalAmount,
    required String currency,
    required String countryCode,
    required Function(PaymentType) onSelectionDone,
  }) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        enableDrag: true,
        useRootNavigator: true,
        backgroundColor: Colors.white,
        context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
            child: Wrap(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Expanded(child: SizedBox()),
                    CustomText(
                      title: AppLocalizations.of(context)!.pay,
                      textColor: const Color(0xff444444),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                mainPaymentView(
                  context: context,
                  currency: currency,
                  countryCode: countryCode,
                  totalAmount: totalAmount,
                  openNext: (type) {
                    Navigator.pop(context);
                    onSelectionDone(type);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget mainConverterView(
      {required BuildContext context,
      required double totalAmount,
      required String mentorCurrency,
      required double dollerEquvilant,
      required Function(double) openNext}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xffE8E8E8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  CustomText(
                    title: AppLocalizations.of(context)!.moneyconversiondesc,
                    textColor: const Color(0xff444444),
                    fontSize: 14,
                    textAlign: TextAlign.center,
                    maxLins: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CustomText(
                        title: "${AppLocalizations.of(context)!.totalamount} :",
                        textColor: const Color(0xff444444),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      Expanded(child: const SizedBox()),
                      CustomText(
                        title: "$totalAmount $mentorCurrency",
                        textColor: const Color(0xff444444),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xffE8E8E8),
                          ),
                        ),
                        child: CustomText(
                          title: "1.0 $mentorCurrency",
                          textColor: const Color(0xff444444),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const CustomText(
                        title: " = ",
                        textColor: Color(0xff444444),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xffE8E8E8),
                          ),
                        ),
                        child: CustomText(
                          title: "$dollerEquvilant \$",
                          textColor: const Color(0xff444444),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CustomText(
                        title:
                            "${AppLocalizations.of(context)!.newtotalamount} :",
                        textColor: const Color(0xff444444),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      Expanded(child: const SizedBox()),
                      CustomText(
                        title:
                            "${calculateNewAmount(totalAmount: totalAmount, dollerEquavilant: dollerEquvilant).toStringAsFixed(2)} \$",
                        textColor: const Color(0xff444444),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
              enableButton: true,
              buttonTitle: AppLocalizations.of(context)!.confirm,
              onTap: () {
                openNext(calculateNewAmount(
                    totalAmount: totalAmount,
                    dollerEquavilant: dollerEquvilant));
              })
        ],
      ),
    );
  }

  double calculateNewAmount(
      {required double totalAmount, required double dollerEquavilant}) {
    return totalAmount * dollerEquavilant;
  }

  Widget mainPaymentView(
      {required BuildContext context,
      required double totalAmount,
      required String countryCode,
      required String currency,
      required Function(PaymentType) openNext}) {
    final String amount = totalAmount.toStringAsFixed(2);
    final paymentItems = [
      PaymentItem(
        label: AppLocalizations.of(context)!.total,
        amount: amount,
        status: PaymentItemStatus.final_price,
      )
    ];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xffE8E8E8),
          ),
        ),
        child: Platform.isAndroid
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: GooglePayButton(
                  paymentConfiguration: PaymentConfiguration.fromJsonString(
                      googlePaymnet(
                          countryCode: countryCode, currency: currency)),
                  onError: (error) {
                    logDebugMessage(message: error.toString());
                  },
                  paymentItems: paymentItems,
                  onPaymentResult: (map) {
                    openNext(PaymentType.google);
                  },
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8),
                child: ApplePayButton(
                  paymentConfiguration: PaymentConfiguration.fromJsonString(
                      applePaymnet(
                          countryCode: countryCode, currency: currency)),
                  onError: (error) {
                    logDebugMessage(message: error.toString());
                  },
                  paymentItems: paymentItems,
                  type: ApplePayButtonType.buy,
                  onPaymentResult: (map) {
                    openNext(PaymentType.apple);
                  },
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
      ),
    );
  }

  String applePaymnet({required String countryCode, required String currency}) {
    // ignore: leading_newlines_in_multiline_strings
    return '''{
                  "provider": "apple_pay",
                  "data": {
                  "merchantIdentifier": "merchant.com.legalzhub.app",
                  "displayName": "LegalzHub",
                  "merchantCapabilities": ["3DS", "debit", "credit"],
                  "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
                  "countryCode": "$countryCode",
                  "currencyCode": "$currency"
                  }
                  }''';
  }

  String googlePaymnet(
      {required String countryCode, required String currency}) {
    // ignore: leading_newlines_in_multiline_strings
    return '''{
                  "provider": "google_pay",
                  "data": {
                    "environment": "TEST",
                    "apiVersion": 2,
                    "apiVersionMinor": 0,
                    "allowedPaymentMethods": [
                      {
                      "type": "CARD",
                      "tokenizationSpecification": {
                      "type": "PAYMENT_GATEWAY",
                      "parameters": {
                      "gateway": "example",
                      "gatewayMerchantId": "gatewayMerchantId"
                      }
                    },
                    "parameters": {
                    "allowedCardNetworks": ["VISA", "MASTERCARD"],
                    "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
                    "billingAddressRequired": true,
                    "billingAddressParameters": {
                        "format": "FULL",
                        "phoneNumberRequired": true
                      }
                      }
                    }
                  ],
                  "merchantInfo": {
                  "merchantId": "BCR2DN4TVGT6XBT7",
                  "merchantName": "LegalzHub"
                  },
                  "transactionInfo": {
                    "countryCode": "$countryCode",
                    "currencyCode": "$currency"
                    }
                  }
                  }''';
  }
}
