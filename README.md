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

2. Log in to the DevRev [Application](app.devrev.ai) and navigate to the `connections` menu to connect to your Kubernetes

3. The App will generate the application access token required and surface the command similar as below with the required credentials to execute on your cluster.
   ```  
   helm upgrade --install  k8s-info-cron-service ./k8s-info-collector-charts/k8s-info-cron-service  
   --set secret.applicationToken=$AAT_TOKEN --create-namespace --namespace=k8s-info-cron-service
   ```

4. You can view the cronjob on the cluster using the following command
   ``` 
   kubectl describe cronjob -n k8s-info-cron-service 
   ```

5. The collector cron job by default runs once every 6 hours. This frequency can be tuned by adding the cronString parameters to the command while
   installing the collector. The below example will make the cronjob run every hour.
   ``` 
   helm upgrade --install k8s-info-cron-service ./k8s-info-collector-charts/k8s-info-cron-service  
   --set secret.applicationToken=$AAT_TOKEN --create-namespace --namespace=k8s-info-cron-service 
   --set cronString='0 */1 * * *' 
   ```
6. Learn more about Parts Discovery [here](https://devrev.ai/docs/product/parts)
