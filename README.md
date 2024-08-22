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

---

## For Rate limit configuration

- Advanced configuration via environment variables can be done via `env.extra`. For example:
```
env:
  extra:
    REDIS_POOL_SIZE: 2
```
- Redis must be deployed separately from this chart.
  - For environment variables related to redis such as TLS configuration, security, etc, refer [here](https://github.com/envoyproxy/ratelimit?tab=readme-ov-file#redis)
- By default, this chart is configured to use the same version of [ratelimit](https://github.com/envoyproxy/ratelimit) as provided in the [Istio samples](https://github.com/istio/istio/blob/master/samples/ratelimit/rate-limit-service.yaml). To update the version, set `image.tag` as needed.
- For the rate limiter to work, configuration must be provided in [this format](https://github.com/envoyproxy/ratelimit?tab=readme-ov-file#configuration). When configurations are defined as shown below, a configmap is created and mounted in the application. By default, any changes to the configmap, either via direct edits during runtime or via helm upgrade, will be picked up by the application shortly.
```
configurations:
  echo-ratelimit.yaml: |
    domain: echo-ratelimit
    descriptors:
      - key: PATH
        value: "/"
        rate_limit:
          unit: minute
          requests_per_unit: 1
      - key: PATH
        rate_limit:
          unit: minute
          requests_per_unit: 100
  httpbin-ratelimit.yaml: |
    domain: httpbin-ratelimit
    descriptors:
      - key: PATH
        value: "/headers"
        rate_limit:
          unit: minute
          requests_per_unit: 200
```

### Installation

Once Helm has been set up correctly, add the repo as follows:

  helm repo add imesh https://charts.imesh.ai

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
imesh` to see the charts.

To install the ratelimit chart in default mode:

    helm install imesh-ratelimit imesh/ratelimit --namespace imesh --create-namespace

To uninstall the chart:

    helm delete imesh-ratelimit --namespace imesh
