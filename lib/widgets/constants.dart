import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const kPrimaryCol = Color(0xfff1bb274);
const kPrimaryLightCol = Color(0xfffeeeee4);
final supabase = Supabase.instance.client;



Map<String,Duration> durationMap = {
  '1 Hour'  :  const Duration(hours: 1),
  '6 Hours' :  const Duration(hours: 6) ,
  '12 Hours':  const Duration(hours: 12) ,
  '24 Hours':  const Duration(hours: 24) ,
  '1 Day' :    const Duration(days: 1),
  '2 Day':     const Duration(days: 2),
  '3 Day':     const Duration(days: 3)
} ;