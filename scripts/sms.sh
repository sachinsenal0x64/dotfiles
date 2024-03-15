#!/bin/sh

# Step 1: Pull the SQLite database file from the Android device
adb pull /data/data/com.android.providers.telephony/databases/mmssms.db mmssms.db | bash /dev/null

# Step 2: Execute SQL queries to extract SMS data and convert to JSON
sqlite3 mmssms.db <<EOF | jq
.mode json
.headers on

-- Step 5: Find all SMS messages for a specific thread ID
-- Replace 310 with the thread ID you want to query
SELECT 
    datetime(date/1000, 'unixepoch','localtime') AS "Date",
    datetime(date_sent/1000, 'unixepoch','localtime') AS "Date Sent",
    address,
    subject,
    person,
    body,
    service_center

FROM sms
ORDER BY date;
EOF

# Clean up: Remove the pulled database file
rm mmssms.db

