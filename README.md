# k8s-info-collector-charts
Helm chart for enabling cron pod on the kubernetes cluster to upload cluster data to DevRev cloud.

## Prerequisite

1. [Install git](https://git-scm.com/downloads) if not already installed

2. [Install Helm](https://helm.sh/docs/intro/install) if not already installed

## Steps to install charts on cluster

The following commands must be executed on the cluster after all prerequisite are installed.

1. Clone this repository
   ``` 
   git clone https://github.com/devrev/k8s-info-collector-charts.git 
   ```

2. Log in to the DevRev [Application](https://app.devrev.ai) and navigate to the `connections` menu to connect to your Kubernetes

3. Generate Application access token (`AAT`)
   1. To generate application access token user need to use Personal Access Token(`PAT`) generated through DevRev application.
      1. How to Generate `PAT`? 
         1. After logging in to DevRev app click on the organization icon and select `DevOrg Settings`.
         2. Select `Account` tab. 
         3. Scroll to the section `Personal Access Token` and generate `New Token` (Please note down the PAT as its visible only one time). 
         4. For some reason if you lose PAT create new one with above steps
   2. Use below curl command to generate `AAT`. Make sure you replace `<PAT>` in command with the actual `PAT` obtained in above step. From response copy the `access_token` which is your `AAT`.
       ```
       curl --location --request POST 'https://api.devrev.ai/token' \
       --header 'Content-Type: application/json' \
       --header 'Authorization: <PAT>' \
       --data-raw '{
       "grant_type" : "urn:devrev:params:oauth:grant-type:token-issue",
       "requested_token_type" : "urn:devrev:params:oauth:token-type:aat",
       "expires_in":"365",
       "token_hint":"kubernetes data for parts discovery"
       }'
       ```
4. Set env variable using `AAT` generated in above Step
    ```
    export AAT_TOKEN=<AAT GENERATED>
    ```
5. Execute below command to upgrade helm chart on your kubernetes cluster.
   ```  
   helm upgrade --install  k8s-info-cron-service ./k8s-info-collector-charts/k8s-info-cron-service \
   --set secret.applicationToken=$AAT_TOKEN --create-namespace --namespace=k8s-info-cron-service
   ```

6. You can view the cronjob on the cluster using the following command
   ``` 
   kubectl describe cronjob -n k8s-info-cron-service 
   ```

7. The collector cron job by default runs once every 6 hours. This frequency can be tuned by adding the cronString parameters to the command while
   installing the collector. The below example will make the cronjob run every hour.
   ``` 
   helm upgrade --install k8s-info-cron-service ./k8s-info-collector-charts/k8s-info-cron-service \
   --set secret.applicationToken=$AAT_TOKEN --create-namespace --namespace=k8s-info-cron-service \
   --set cronString='0 */1 * * *'
   ```
8. Learn more about Parts Discovery [here](https://devrev.ai/docs/product/parts)