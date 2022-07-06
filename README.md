# k8s-info-collector-charts
Helm chart for enabling cron pod on the kubernetes cluster to upload cluster data to DevRev cloud.

git clone https://github.com/devrev/k8s-info-collector-charts.git
curl --silent --location --request POST 'https://api.devrev.ai/token' \
--header 'Content-Type: application/json' \
--header "Authorization: $(cat /tmp/token)" \
--data-raw '{
"grant_type" : "urn:devrev:params:oauth:grant-type:token-issue",
"requested_token_type" : "urn:devrev:params:oauth:token-type:aat"
}' | base64 -o /tmp/aat
helm install k8s-info-cron-service ./k8s-info-collector-charts/k8s-info-cron-service  --set secret.applicationToken=$(cat /tmp/file)| --create-namespace --namespace=k8s-info-cron-service 
