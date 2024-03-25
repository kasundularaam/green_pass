import 'package:flutter/material.dart';

import 'package:green_pass/models/event_model.dart';

import '../models/ticket_model.dart';
import '../pages/enter_card_details.dart';
import '../widgets/custom_filled_button.dart';
import '../widgets/custom_paymentmethod_button.dart';

class SelectPaymentMethod extends StatefulWidget {
  final Event event;
  final Ticket ticket;
  final int quantity;
  const SelectPaymentMethod({
    super.key,
    required this.event,
    required this.ticket,
    required this.quantity,
  });

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  String ticketID = "";
  int? quantity;
  int selectedButtonIndex = -1;
  Ticket? selectedTicket;
  Event? selectedEvent;
  void onSelectButton(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Select Payment Method",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OverflowBar(
                overflowSpacing: 11,
                children: [
                  CustomPaymentMethodButton(
                    isSelected: selectedButtonIndex == 0,
                    onSelect: (isSelected) => onSelectButton(0),
                    methodName: "Mastercard",
                    imageURL: "lib/assets/mastercard.png",
                  ),
                  CustomPaymentMethodButton(
                    isSelected: selectedButtonIndex == 1,
                    onSelect: (isSelected) => onSelectButton(1),
                    methodName: "Visa",
                    imageURL: "lib/assets/visa.png",
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        textStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: CustomFilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EnterCardDetails(
                                      event: widget.event,
                                      ticket: widget.ticket,
                                      quantity: widget.quantity)),
                            );
                          },
                          buttonText: "Confirm"),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
