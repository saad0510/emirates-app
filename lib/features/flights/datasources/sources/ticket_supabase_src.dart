import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../data/entities/ticket.dart';
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

  @override
  Future<Iterable<TicketModel>> getAllTickets(
    String uid,
    TicketListState state,
  ) async {
    try {
      var query = client //
          .from(tableName)
          .select('''
            *, flight_data:flights!inner( *,
                  departure_city_data:cities!flights_departure_city_fkey(*),
                  arrival_city_data:cities!flights_arrival_city_fkey(*)
                )
          ''').eq('created_by', uid);

      if (state == TicketListState.old) {
        query = query.lt(
          'flight_data.departure_time',
          DateTime.now().toIso8601String(),
        );
      } else if (state == TicketListState.upcoming) {
        query = query.gt(
          'flight_data.departure_time',
          DateTime.now().toIso8601String(),
        );
      }

      final List tickets = await query;

      return tickets.map((e) => TicketModel.fromMap(e));
    } on PostgrestException catch (e) {
      log('getAllTickets: $e', name: 'TicketSupabaseSrc');
      throw TicketException('unknown-ticket-id', e.message);
    } catch (e) {
      log('getAllTickets: $e', name: 'TicketSupabaseSrc');
      rethrow;
    }
  }
}
