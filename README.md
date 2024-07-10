# imesh-platform-helm-charts

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add imesh-agent https://charts.imesh.ai

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
imesh-agent` to see the charts.

To install the cluster-agent chart:

    helm install agent imesh-agent/cluster-agent --namespace imesh --create-namespace --set clusterAgent.env.agentToken="<agent_token>"

To uninstall the chart:

    helm delete agent --namespace imesh
