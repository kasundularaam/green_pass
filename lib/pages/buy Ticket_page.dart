import 'package:green_pass/models/event_model.dart';
import 'package:green_pass/pages/select_payment_method_page.dart';
import 'package:flutter/material.dart';
import '../models/ticket_model.dart';
import '../widgets/custom_filled_button.dart';
import '../widgets/custom_toggle_button.dart';
import '../widgets/ticket_medium.dart';
import '../widgets/total_price_container.dart';

class BuyTicketPage extends StatefulWidget {
  final Event event;
  final List<Ticket> tickets;
  const BuyTicketPage({super.key, required this.event, required this.tickets});

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  double totalPrice = 0;
  int ticketCount = 0;
  double ticketPrice = 0;
  Ticket? selectedTicket;
  Event? selectedEvent;
  int selectedButtonIndex = -1;

  void incrementTicketCount() {
    setState(() {
      ticketCount++;
      totalPrice = ticketCount * ticketPrice;
    });
  }

  void decrementTicketCount() {
    setState(() {
      ticketCount--;
      totalPrice = ticketCount * ticketPrice;
    });
  }

  void onSelectButton(int index, Ticket ticket) {
    setState(() {
      ticketPrice = ticket.ticketPrice;
      totalPrice = ticketCount * ticketPrice;
      selectedButtonIndex = index;
      selectedTicket = ticket;
    });
  }

  List<Ticket> sortedTickets() {
    final List<Ticket> tickets = widget.tickets;
    widget.tickets.sort((a, b) => a.ticketPrice.compareTo(b.ticketPrice));
    return tickets;
  }

  @override
  void initState() {
    onSelectButton(0, widget.tickets.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          "Buy Ticket",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  TicketMedium(
                    event: widget.event,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: widget.tickets.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 11),
                              child: CustomToggleButton(
                                isSelected: selectedButtonIndex == index,
                                onSelect: (val) => onSelectButton(index, val),
                                ticket: sortedTickets()[index],
                              ),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            if (ticketCount > 0) {
                              decrementTicketCount();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 23,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            ticketCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                        ),
                        FilledButton(
                          onPressed: () {
                            incrementTicketCount();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15),
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: TotalPriceContainer(
                      totalPrice: totalPrice,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomFilledButton(
                        onPressed: ticketCount == 0
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectPaymentMethod(
                                          event: widget.event,
                                          ticket: selectedTicket!,
                                          quantity: ticketCount)),
                                );
                              },
                        buttonText: "Buy Ticket(s)"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
