import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voya/core/shared/custom_header.dart';
import '../../data/models/booking_request_model.dart';
import '../../logic/cubit/booking_cubit.dart';
import '../../logic/cubit/booking_state.dart';
import 'package:voya/features/passenger/history/logic/cubit/history_cubit.dart';

class PaymentScreen extends StatefulWidget {
  final int tripId;
  final int numberOfSeats;
  final double totalPrice;

  const PaymentScreen({
    super.key,
    required this.tripId,
    required this.numberOfSeats,
    required this.totalPrice,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedMethod;
  File? _receiptImage;
  final ImagePicker _picker = ImagePicker();

  final Map<String, String> _paymentDetails = {
    "InstaPay": "voya@instapay",
    "Bank Transfer": "1234-5678-9012-3456",
    "Wallet Transfer": "01207201864",
  };

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _receiptImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FE),
      body: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.read<HistoryCubit>().fetchMyTrips();
            Navigator.pop(context); // Pop Payment
            Navigator.pop(context); // Pop Booking
          } else if (state is BookingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomHeader(title: 'Payment'),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "SELECT PAYMENT METHOD",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF5A6B87),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildPaymentMethodTile(
                          title: "InstaPay",
                          icon: Icons.account_balance_wallet_outlined,
                        ),
                        _buildPaymentMethodTile(
                          title: "Bank Transfer",
                          icon: Icons.account_balance_outlined,
                        ),
                        _buildPaymentMethodTile(
                          title: "Wallet Transfer",
                          icon: Icons.smartphone_outlined,
                        ),
                        if (_selectedMethod != null) ...[
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF1FF),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(
                                  0xFF0D32B3,
                                ).withValues(alpha: 0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Transfer to this $_selectedMethod ID:",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF5A6B87),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _paymentDetails[_selectedMethod]!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF0D32B3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: _paymentDetails[_selectedMethod]!,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Copied to clipboard"),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                    color: Color(0xFF0D32B3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 30),
                        const Text(
                          "UPLOAD RECEIPT",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF5A6B87),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: const Color(0xFFD6DFF7),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: _receiptImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(28),
                                    child: Image.file(
                                      _receiptImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 48,
                                        color: Color(0xFF0D32B3),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Click to upload payment receipt",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(
                                            0xFF5A6B87,
                                          ).withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D32B3),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed:
                                (state is BookingLoading ||
                                    _receiptImage == null)
                                ? null
                                : () {
                                    context.read<BookingCubit>().createBooking(
                                      BookingRequestModel(
                                        tripId: widget.tripId,
                                        numberOfSeats: widget.numberOfSeats,
                                        receiptImage: _receiptImage,
                                      ),
                                    );
                                  },
                            child: state is BookingLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Confirm Booking",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentMethodTile({
    required String title,
    required IconData icon,
  }) {
    bool isSelected = _selectedMethod == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF0D32B3) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF0D32B3)
                  : const Color(0xFF5A6B87),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                color: isSelected
                    ? const Color(0xFF0D32B3)
                    : const Color(0xFF1E2432),
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF0D32B3),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
