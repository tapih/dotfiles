#!/bin/bash

set -eo pipefail

# Claude Hook for Slack Notifications
# Sends notifications when tasks are completed or waiting for approval

# Check if SLACK_WEBHOOK_CLAUDE environment variable exists
if [ -z "$SLACK_WEBHOOK_CLAUDE" ]; then
  echo "SLACK_WEBHOOK_CLAUDE environment variable not set. Skipping Slack notification."
  exit 0
fi

# Get hook event type and data
EVENT_TYPE="$1"
PROJECT_PATH="$(pwd)"
PROJECT_NAME=$(basename "$PROJECT_PATH")
BRANCH_NAME=$(git branch --show-current 2>/dev/null)

# Function to send Slack notification
send_slack_notification() {
  local emoji="$1"
  local title="$2"
  local detail_message="$3"
  local color="$4"

  curl -X POST -H 'Content-type: application/json' \
    --data "{
            \"text\": \"$emoji Claude Code: $title in $PROJECT_NAME\",
            \"blocks\": [
                {
                    \"type\": \"section\",
                    \"text\": {
                        \"type\": \"mrkdwn\",
                        \"text\": \"*Claude Code Notification*\\nProject: \`$PROJECT_NAME\`\\n$detail_message\"
                    }
                },
                {
                    \"type\": \"section\",
                    \"text\": {
                        \"type\": \"mrkdwn\",
                        \"text\": \"📂 *Path:* \`$PROJECT_PATH\`\\n🌿 *Branch:* \`$BRANCH_NAME\`\"
                    }
                },
                {
                    \"type\": \"context\",
                    \"elements\": [
                        {
                            \"type\": \"mrkdwn\",
                            \"text\": \"Time: $(date +"%Y-%m-%d %H:%M:%S")\"
                        }
                    ]
                }
            ]
        }" \
    "$SLACK_WEBHOOK_CLAUDE" >/dev/null 2>&1
}

# Handle different hook events
case "$EVENT_TYPE" in
"stop")
  send_slack_notification "🛑" "Task Stopped" "Claude task has been stopped" "warning"
  ;;
"notification")
  send_slack_notification "🔔" "Approval Required" "Claude is waiting for your approval to proceed" "warning"
  ;;
"error")
  send_slack_notification "❌" "Error Occurred" "Claude encountered an error while processing" "danger"
  ;;
*)
  echo "Unknown event type: $EVENT_TYPE"
  exit 1
  ;;
esac

echo "Slack notification sent for event: $EVENT_TYPE"
