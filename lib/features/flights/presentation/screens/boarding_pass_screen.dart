import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../../common/presentation/widgets/secondary_button.dart';
import '../../data/entities/ticket.dart';
import '../../data/entities/user_feedback.dart';
import '../controllers/pdf_controller.dart';
import '../widgets/boarding_pass_card.dart';
import '../widgets/rating_form.dart';

class BoardingPassScreen extends StatefulWidget {
  const BoardingPassScreen({super.key, required this.tickets});

  final List<Ticket> tickets;

  @override
  State<BoardingPassScreen> createState() => _BoardingPassScreenState();
}

class _BoardingPassScreenState extends State<BoardingPassScreen> {
  String? path;
  int selected = 0;
  bool lockTransition = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Boarding Pass'),
        actions: [
          Padding(
            padding: AppPaddings.smallX,
            child: IconButton(
              onPressed: shareTicket,
              icon: const Icon(Icons.share),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.worldMap,
              color: context.contrastColor,
              height: 150.sp,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              AppAssets.planeTrace,
              fit: BoxFit.contain,
              width: 200.sp,
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 0.w,
            right: 0.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: context.width,
                  height: context.height,
                  child: Swiper(
                    itemCount: widget.tickets.length,
                    autoplay: !lockTransition,
                    autoplayDelay: 1500,
                    loop: widget.tickets.length > 1,
                    onIndexChanged: (i) {
                      selected = i;
                      if (lockTransition == true) {
                        setState(() => lockTransition = false);
                      }
                    },
                    onTap: (i) {
                      setState(() => lockTransition = true);
                    },
                    itemBuilder: (_, i) {
                      return Column(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: AppPaddings.normalX,
                            child: BoardingPassCard(ticket: widget.tickets[i]),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                AppSizes.normalY,
                Padding(
                  padding: AppPaddings.normalX,
                  child: ElevatedButton(
                    onPressed: () async {
                      await generatePdf();
                      OpenAppFile.open(path!);
                    },
                    child: const Text("Download ticket"),
                  ),
                ),
                AppSizes.smallY,
                Padding(
                  padding: AppPaddings.normalX,
                  child: SecondaryButton(
                    onPressed: () {
                      BottomModalSheet.show(
                        context,
                        child: RatingForm(onSubmit: submitFeedback),
                      );
                    },
                    child: const Text("Rate this flight"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> generatePdf() async {
    bool isGranted = await PdfController.isPermitted();
    if (isGranted == false) return;
    path = await PdfController.generateTicket(
      ticket: widget.tickets[selected],
    );
  }

  void shareTicket() async {
    if (path == null) await generatePdf();
    Share.shareXFiles(
      [XFile(path!)],
      text: 'My boarding pass for ${widget.tickets[selected].flight.fid}',
    );
  }

  void submitFeedback(int rating, String comment) async {
    final feed = UserFeedback(
      uid: context.read<AuthController>().user.uid,
      fid: widget.tickets[selected].flight.fid,
      rating: rating,
      comment: comment,
    );
    await Supabase.instance.client //
        .from("feedback")
        .upsert(feed.toMap());
  }
}
