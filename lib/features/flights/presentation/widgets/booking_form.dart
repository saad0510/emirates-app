import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/utils/form_validations.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../controllers/booking/booking_controller.dart';
import '../controllers/booking/booking_state.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  int quantity = 0;
  final formKey = GlobalKey<FormState>();
  late final controller = context.read<BookingController>();

  @override
  void initState() {
    controller.addListener(handleState);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(handleState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSizes.normalY,
          TextField(
            style: context.textTheme.bodyText2,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Number of tickets (1 to 10)",
            ),
            onChanged: (x) {
              quantity = int.tryParse(x) ?? 0;
              quantity = quantity < 0 || quantity > 10 ? 0 : quantity;
              controller.quantity = quantity;
              setState(() {});
            },
          ),
          AppSizes.smallY,
          //
          for (int i = 0; i < quantity; i++)
            Padding(
              padding: AppPaddings.smallY,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: context.textTheme.bodyText2,
                      decoration: const InputDecoration(
                        hintText: "Full Name",
                      ),
                      onSaved: (x) => controller.names[i] = x!,
                      keyboardType: TextInputType.name,
                      validator: FormValidations.name,
                    ),
                  ),
                  AppSizes.smallX,
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      height: 50.sp,
                      elevation: 0,
                      onPressed: controller.seats[i].isNotEmpty ? null : () => chooseSeat(i),
                      color: context.backgroundColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        controller.seats[i].isNotEmpty ? controller.seats[i] : 'Seat',
                        style: context.textTheme.bodyText2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ...quantity > 0
              ? [
                  AppSizes.smallY,
                  ElevatedButton(
                    onPressed: submit,
                    child: const Text('Continue'),
                  ),
                ]
              : []
        ],
      ),
    );
  }

  void submit() {
    if (!mounted) return;
    final valid = formKey.currentState!.validate();
    if (!valid) return;
    formKey.currentState!.save();

    if (controller.seats.contains('')) {
      context.showErrorSnackBar(message: "Select all seats");
      return;
    }

    final uid = context.read<AuthController>().user.uid;
    controller.generateTickets(uid);
  }

  void chooseSeat(int i) {
    context.push(
      AppRoutes.seats,
      arguments: (seat) {
        setState(() => controller.seats[i] = seat);
      },
    );
  }

  void handleState() {
    if (!mounted) return;

    final state = controller.state;
    if (state is BookingGeneratedState) {
      context.push(
        AppRoutes.orderSummary,
        arguments: controller,
      );
    } else if (state is BookingConfirmedState) {
      Future.delayed(Duration.zero).then(
        (_) => context.push(
          AppRoutes.payment,
          arguments: controller,
        ),
      );
    } else if (state is BookingCompletedState) {
      Future.delayed(Duration.zero).then(
        (_) {
          context.replace(
            AppRoutes.boardingPass,
            arguments: controller.tickets,
          );
        },
      );
    }
  }
}
