class ApiConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String users = '/users';
  static const String posts = '/posts';
  
  
  
  static const String tripLogsBaseUrl = 'https://dt1wp7hrm9.execute-api.ap-south-1.amazonaws.com';
  static const String tripLogsEndpoint = '/auth/api/crm-member/trip-logs/trip';
  
  // Auth token - In production, store this securely
  static const String bearerToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhYmViYjA5My00MzAyLTRmOTMtODRhMi01MjEzMzI4ZDVjYjAiLCJ1c2VyX2lkIjoiYWJlYmIwOTMtNDMwMi00ZjkzLTg0YTItNTIxMzMyOGQ1Y2IwIiwidXNlcl90eXBlIjoiQWRtaW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJBbmlrZXQgUGF3YXIiLCJjbGllbnRfaWQiOiI5Yzg5OTEwMy0wOWYxLTQxMTMtOTcxNC1jMTEyZDg3NDFjZGMiLCJyb2xlX2lkIjoiZjVjMDU1ODItMGFmMC00MmJhLWE0ZjgtNjY4OTgyYjNhMDliIiwicGVybWlzc2lvbnMiOltdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOltdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOltdfX0sImlhdCI6MTc0OTUzMDk5OCwiZXhwIjoxNzQ5NjE3Mzk4fQ.GdZNcCeMwocI3LhHXo0MxkafX7fJICdA7cRemijZu2A';
  

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}
