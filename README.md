# k8s-info-collector-charts
Helm chart for enabling cron pod on the kubernetes cluster to upload cluster data to DevRev cloud.

The following commands must be executed on the cluster

1. Clone this repository
   ``` 
       git clone https://github.com/devrev/k8s-info-collector-charts.git 
   ```

2. Log in to the DevRev App using app.devrev.ai and navigate to the connections menu to connect to Kubernetes

3. The App will generate the applocation access token required and surface the below command with the required credentials to execute on your cluster.

    ```  
       helm upgrade --install  k8s-info-cron-service ./k8s-info-collector-charts/k8s-info-cron-service  --set secret.applicationToken=$AAT_TOKEN --create-namespace 
      --namespace=k8s-info-cron-service
    ```

4. You can view the cronjob on the cluster using the following command
    ``` 
        kubectl describe cronjob -n k8s-info-cron-service 
    ```

5. The collector cron job by default runs once every 6 hours. This frequency can be tuned by adding the cronString parameters to the command while
   installing the collector. The below example will make the cronjob run every hour.
   ``` 
       helm upgrade --install k8s-info-cron-service ./k8s-info-collector-charts/k8s-info-cron-service  --set secret.applicationToken=$(cat /tmp/aat) 
       --create-namespace --namespace=k8s-info-cron-service --set cronString='* */1 * * *' 
   ```
