#!/usr/bin/env bash

CONTENT_TYPE="Content-Type: application/json"
PROSPECT_FLAG="{\"prospect_only\": true}"
SEEDLING_EMAIL_GETTER='.account.email'
PAL_LOGIN_TOKEN_GETTER='.data.palAppLoginV2.token'
ADMIN_LOGIN_TOKEN_GETTER='.data.loginAdmin.token'
DEFAULT_ACCOUNT_PASSWORD="Hol1d@y!123!"
DEFAULT_ADMIN_ACCOUNT="admin@joinpapa.com"

PROSPECT_CREATE_TEXT="Using Seedling to create a new Prospect Pal.."
PAL_CREATE_TEXT="Using Seedling to create a new Pal.."

seed() {
  echo "Seeding $1 via Seedling API"
}

login() {
  echo "Logging in as $1"
}

# Check if ~/.hammercurl/ directory exists, if not then create it
if [ ! -d "$HOME/.hammercurl" ]; then
  mkdir -p "$HOME/.hammercurl"
  mkdir -p "$HOME/.hammercurl/gql"
fi

if gum confirm "Use existing RA environment or setup a new one?" --affirmative="Existing" --negative="New"; then
  HAMMER_ENV_NAME=$(ls ~/.hammercurl/ | grep -v gql | gum choose --header="Select an Environment..")
fi

# File path
FILE="$HOME/.hammercurl/$HAMMER_ENV_NAME"

# Check if the file exists
if [ -f "$FILE" ]; then
  # If it exists, source it
  source "$FILE"
  GQL_URL="https://$RA_NAME.backend.papadev.co/api/graphql"
  SEEDLING_URL="https://$RA_NAME.backend.papadev.co/seedling/api/pals/new"
else
  RA_NAME=$(gum input --placeholder="Review App Name...")
  USER_TYPE=$(gum choose "admin" "prospect" "pal" --header="Select Account type to login as")
  SEEDLING_TEXT=$(seed "$USER_TYPE")
  LOGIN_TEXT=$(login "$USER_TYPE")

  HAMMER_ENV_NAME="${RA_NAME}_${USER_TYPE}"
  FILE="$HOME/.hammercurl/$HAMMER_ENV_NAME"
  GQL_URL="https://$RA_NAME.backend.papadev.co/api/graphql"
  SEEDLING_URL="https://$RA_NAME.backend.papadev.co/seedling/api/pals/new"

  if [ "$USER_TYPE" = "prospect" ]; then

    ACCOUNT_EMAIL=$(gum spin --title="$SEEDLING_TEXT" --show-output -- curl -X POST "$SEEDLING_URL" -H "$CONTENT_TYPE"  -d "{ \"prospect_only\": true }" | jq -r $SEEDLING_EMAIL_GETTER) 

    PAL_LOGIN_MUTATION='{ "query": "mutation { palAppLoginV2(input: {email: \"'$ACCOUNT_EMAIL'\", password: \"'$DEFAULT_ACCOUNT_PASSWORD'\"}) { token } }"}'
    LOGIN_TOKEN=$(gum spin --title="$LOGIN_TEXT" --show-output -- curl -X POST "$GQL_URL" -H "$CONTENT_TYPE" -d "$PAL_LOGIN_MUTATION" | jq -r '.data.palAppLoginV2.token')
  elif [ "$USER_TYPE" = "pal" ]; then

    ACCOUNT_EMAIL=$(gum spin --title="$SEEDLING_TEXT" --show-output -- curl -X POST "$SEEDLING_URL" -H "Content-Type: application/json"  | jq -r $SEEDLING_EMAIL_GETTER)
    PAL_LOGIN_MUTATION='{ "query": "mutation { palAppLoginV2(input: {email: \"'$ACCOUNT_EMAIL'\", password: \"'$DEFAULT_ACCOUNT_PASSWORD'\"}) { token } }"}'
    LOGIN_TOKEN=$(gum spin --title="$LOGIN_TEXT" --show-output -- curl -X POST "$GQL_URL" -H "$CONTENT_TYPE" -d "$PAL_LOGIN_MUTATION" | jq -r '.data.palAppLoginV2.token')
  else
    ACCOUNT_EMAIL=$DEFAULT_ADMIN_ACCOUNT
    ADMIN_LOGIN_MUTATION='{ "query": "mutation { loginAdmin(input: {email: \"'$ACCOUNT_EMAIL'\", password: \"'$DEFAULT_ACCOUNT_PASSWORD'\"}) { token } }"}'
    LOGIN_TOKEN=$(gum spin --title="$LOGIN_TEXT" --show-output -- curl -X POST "$GQL_URL" -H "$CONTENT_TYPE" -d "$ADMIN_LOGIN_MUTATION" | jq -r '.data.loginAdmin.token')
  fi

  echo ":white_check_mark: Successfully logged in as $ACCOUNT_EMAIL. User Type: $USER_TYPE" | gum format -t emoji

  # If the file does not exist, create it and write the environment variables to it
  {
    echo "export RA_NAME='$RA_NAME'"
    echo "export ACCOUNT_EMAIL='$ACCOUNT_EMAIL'"
    echo "export ACCOUNT_PASSWORD='$DEFAULT_ACCOUNT_PASSWORD'"
    echo "export LOGIN_TOKEN='$LOGIN_TOKEN'"
  } > "$FILE"
  source "$FILE"
fi

AUTHORIZATION="Authorization: Bearer $LOGIN_TOKEN"

NEW_QUERY="New.."
EXIT="Exit"
# Run Queries until they're done
while true; do
  KNOWN_QUERIES=$(ls ~/.hammercurl/gql/)
  QUERY_NAME=$(gum choose $NEW_QUERY $EXIT $KNOWN_QUERIES --header="Select Query To Use")
  QUERY=""

  if [ "$QUERY_NAME" = "$NEW_QUERY" ]; then
    QUERY_NAME=$(gum input --placeholder="a snake_case name with no spaces, and no file extensions :)")
    QUERY_NAME="${QUERY_NAME}.gql"
    touch "$HOME/.hammercurl/gql/$QUERY_NAME"
  fi

  if [ "$QUERY_NAME" != "$EXIT" ]; then
    $EDITOR "$HOME/.hammercurl/gql/$QUERY_NAME"
    QUERY=$(cat "$HOME/.hammercurl/gql/$QUERY_NAME")
    echo ":tada: Running $QUERY_NAME" | gum format -t emoji
    gum spin --title="Running $QUERY_NAME" --show-output -- curl -s -X POST "$GQL_URL" -H "$CONTENT_TYPE" -H "$AUTHORIZATION" -d "{ \"query\": \"$QUERY\" }" | jq .
  else
    exit
  fi
done


echo ":wave: Goodbye." | gum format -t emoji
