import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/ticket_model.dart';
import 'ticket_remote_src.dart';

class TicketSupabaseSrc extends TicketRemoteSrc {
  static const tableName = 'tickets';
  final SupabaseClient client;

  TicketSupabaseSrc({required this.client});

  @override
  Future<void> generateTicket(TicketModel ticket) async {
    try {
      final query = client
          .from(tableName) //
          .insert(ticket.toMap());
      await query;
    } on PostgrestException catch (e) {
      log('generateTicket: $e', name: 'TicketSupabaseSrc');
      throw TicketException('unknown-ticket-id', e.message);
    } catch (e) {
      log('generateTicket: $e', name: 'TicketSupabaseSrc');
      rethrow;
    }
  }
}
