export $(cat .env)

[ ! -z "$ENV" ] || (echo "ENV empty error"; return 1;)
[ ! -z "$GOOGLE_APPLICATION_CREDENTIALS" ] || (echo "GOOGLE_APPLICATION_CREDENTIALS empty error"; return 1;)
[ ! -z "$TFSTATE_BUCKET" ] || (echo "TFSTATE_BUCKET empty error"; return 1;)

# echo "Executing command for env $ENV"