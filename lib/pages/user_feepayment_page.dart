import 'package:busync/components/textfield_component.dart';
import 'package:busync/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../components/user_drawer.dart';

class UserFeePaymentPage extends StatefulWidget {
  const UserFeePaymentPage({super.key});

  @override
  State<UserFeePaymentPage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<UserFeePaymentPage> {
  final _razorpay = Razorpay();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController admnNoController = TextEditingController();
  final TextEditingController paymentAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonFontColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Fee Payment',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: primaryGradient,
          ),
        ),
      ),
      drawer: const UserDrawerIcon(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.fromLTRB(20, 38, 20, 20),
          child: Column(
            children: [
              Image.asset(
                'images/credit_card.png',
                height: 150,
              ),
              const SizedBox(height: 50),
              TextFieldComponent(
                hintText: 'Enter your name',
                obscureText: false,
                controller: nameController,
                icon: const Icon(Icons.person),
              ),
              const SizedBox(height: 15),
              TextFieldComponent(
                hintText: 'Enter your Admn No',
                obscureText: false,
                controller: admnNoController,
                icon: const Icon(Icons.key),
              ),
              const SizedBox(height: 15),
              TextFieldComponent(
                keyboard: TextInputType.number,
                hintText: 'Payment Amount',
                obscureText: false,
                controller: paymentAmountController,
                icon: const Icon(Icons.currency_rupee_rounded),
              ),
              const SizedBox(height: 20),
              SlideAction(
                onSubmit: () {
                  var options = {
                    'key': 'rzp_test_nHUmI4fn1a5JyD',
                    'amount': (double.parse(paymentAmountController.text) *
                            100.roundToDouble())
                        .toString(),
                    'name': nameController.text,
                    'description':
                        'Payment done by ${nameController.text} with Admission number: ${admnNoController.text}',

                    'timeout': 120, // in seconds
                  };
                  _razorpay.open(options);
                  nameController.clear();
                  paymentAmountController.clear();
                  admnNoController.clear();
                  dispose();
                },
                borderRadius: 10,
                height: 65,
                sliderButtonIconPadding: 14,
                text: 'Swipe to Pay',
                textStyle: GoogleFonts.poppins(
                  color: buttonFontColor,
                  fontSize: 18,
                ),
                outerColor: const Color.fromARGB(197, 117, 73, 237),
                innerColor: buttonFontColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
