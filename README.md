# Small POC for Ory stack for OIDC provider

First of all:

```sh
docker compose up -d
```

## Kratos

Open http://localhost:4455/welcome

Sign up, and verify your email on http://localhost:4436/

Just play around.

## Hydra

Open any POSIX or Linux terminal.

Please have jq installed. If you're on Ubuntu/Debian: `sudo apt-get install -y jq`.
Do some research for any other distro/OS.

```bash
client=$(docker compose exec hydra \
    hydra create client \
    --endpoint http://127.0.0.1:4445/ \
    --format json \
    --grant-type client_credentials)

# We parse the JSON response using jq to get the client ID and client secret:
client_id=$(echo $client | jq -r '.client_id')
client_secret=$(echo $client | jq -r '.client_secret')

docker compose exec hydra \
  hydra perform client-credentials \
  --endpoint http://127.0.0.1:4444/ \
  --client-id $client_id \
  --client-secret $client_secret

# YOU WILL GOT AN ACCESS TOKEN HERE

docker-compose exec hydra \
  hydra introspect token \
  --format json-pretty \
  --endpoint http://127.0.0.1:4445/ \
  PASTE YOUR ACCESS TOKEN HERE!

code_client=$(docker compose exec hydra \
    hydra create client \
    --endpoint http://127.0.0.1:4445 \
    --grant-type authorization_code,refresh_token \
    --response-type code,id_token \
    --format json \
    --scope openid --scope offline \
    --redirect-uri http://127.0.0.1:5555/callback)

code_client_id=$(echo $code_client | jq -r '.client_id')
code_client_secret=$(echo $code_client | jq -r '.client_secret')

docker-compose exec hydra \
    hydra perform authorization-code \
    --client-id $code_client_id \
    --client-secret $code_client_secret \
    --endpoint http://127.0.0.1:4444/ \
    --port 5555 \
    --scope openid --scope offline
```

## License

```
   Copyright 2023 Reinaldy Rafli <aldy505@proton.me>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```

See [LICENSE](./LICENSE)