import 'package:supabase_flutter/supabase_flutter.dart';

supabaseConfig() async {
  await Supabase.initialize(
    url: "https://hxwijqirmtqtcszewtxz.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4d2lqcWlybXRxdGNzemV3dHh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3MDI5OTMsImV4cCI6MjAxNzI3ODk5M30.68WS1BWk1wvbyQRy5KuRtP1_u85NkuVCdQnNePTfKes",
  );
}
