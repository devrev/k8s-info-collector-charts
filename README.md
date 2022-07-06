# k8s-info-collector-charts
Helm chart for enabling cron pod on the kubernetes cluster to upload cluster data to DevRev cloud.


helm upgrade --install  k8s-info-cron-service ./k8s-info-collector-charts/k8s-info-cron-service  --set secret.applicationToken=$(cat /tmp/aat) --create-namespace --namespace=k8s-info-cron-service

