# horizon-helm

## Overview
This is the official Helm Chart for installing Horizon on Kubernetes.

## Installation

Add the Helm repo to your local repositories :
```shell
helm repo add evertrust https://repo.evertrust.io/repository/charts
```

You can then use the Chart using the prefix you chose :
```shell
helm install evertrust/horizon
```
## Usage

### Image pull secret
Because the Horizon Docker image is not publicly available, you must provide the chart with registry credentials to pull the image.

This can be done via the `kubectl` command :
```shell
kubectl create secret docker-registry evertrust-registry \
--docker-server=registry.evertrust.io \
--docker-username=<username> \
--docker-password=<password>
```
If deploying to a specific namespace, don't forget to namespace the secret accordingly.

Once done, tell the chart to use the newly created secret by adding an entry in the `imagePullSecrets` key in `values.yaml`:
```yaml
imagePullSecrets:
  - name: evertrust-registry
```

### License
You must have a valid license to deploy Horizon. Create a secret in the namespace you want to deploy Horizon to and reference it in your `values.yaml` under the `horizon.license` key:
```yaml
horizon:
  license:
    secretName: horizon-license
    secretKey: license
```

### Secrets
The chart is unopinionated about you should handle your secrets. Therefore, if you wish to use the Kubernetes secrets implementation, you must create the secrets beforehand and inject them in Horizon pods using the `environment` key in `values.yaml`.

To get your application up and running, you may inject the following environment variables :
```yaml
environment:
  - name: MONGODB_URI
    value: <MONGO_URI>
  - name: APPLICATION_SECRET
    value: <APPLICATION_SECRET>
  - name: DEFAULT_SSV_SECRET
    value: <DEFAULT_SSV_SECRET>
```
You can also fetch those values from a Kubernetes secret :
```yaml
environment:
  - name: MONGO_URI
      valueFrom:
        secretKeyRef:
          name: mongo-secret
          key: uri
```

Another option would be to inject the env variables via a sidecar helper (like the [Hashicorp Vault](https://www.vaultproject.io/docs/platform/k8s/injector) one).  
You can find a list of environment-fetched config values in `values.yaml` since they use the `"${?VAR_NAME}"` syntax. You may also add/remove environment-fetched variables at your convenience.