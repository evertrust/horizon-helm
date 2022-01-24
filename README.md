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

Once done, tell the chart to use the newly created secret by adding an entry in the `image.pullSecrets` key in `values.yaml`:
```yaml
image:
  pullSecrets:
    - evertrust-registry
```

### License
You must also have a valid license to deploy Horizon. Create a secret in the namespace you want to deploy Horizon to :
```shell
kubectl create secret generic horizon-license \
--from-literal="license=<license>"
```
When doing so, take care to remove newlines in your license.

Then, reference it in your `values.yaml` under the `license` key:
```yaml
license:
  secretName: horizon-license
  secretKey: license
```

### Secrets
Secret values should not be stored in your `values.yaml` file in a production environment.
Instead, you should create Kubernetes secrets beforehand or inject them directly into the pod.

Values that should be treated as secrets in this chart are :
- `appSecret`
- `vaults.*.master_password`
- `mailer.password`
- `externalDatabase.uri`

For each of these values, either :
- leave the field empty, so that a secret will be automatically generated.*
- specify a value directly (not recommended in productions as Helm values are exposed) :
```yaml
appSecret:
  value: <app secret>
```
- derive the secret value from an existing Kubernetes secret :
```yaml
appSecret:
  valueFrom:
    secretKeyRef:
      name: <secret name>
      key: <secret key>
```

> :warning: *Always store auto-generated secrets in a safe place after they're generated. If you ever uninstall your Helm chart, the deletion of the SSV secret will lead to the impossibility of recovering most of your data.

### Database
When installing the chart, you face multiple options regarding your database :

- By default, a local MongoDB standalone instance will be spawned in your cluster, using the [`bitnami/mongodb`](https://github.com/bitnami/charts/tree/master/bitnami/mongodb) chart. No additional configuration is required but it is not production ready.
- If you want to use an existing MongoDB instance, provide the `externalDatabase.uri` value. The URI should be treated as a secret as it must include credentials.

### Running behind a Docker registry proxy
If your installation environment requires you to whitelist images that can be pulled by the Kubernetes cluster, you must whitelist the `registry.evertrust.io/horizon` image.

Additionally, when configured to do so, the chart will spawn a local MongoDB instance with the `docker.io/bitnami/mongodb` image and check the database connectivity with the `docker.io/groundnuty/k8s-wait-for:v1.3` image.

## Parameters

### Global parameters

| Name                | Description                                                          | Value |
| ------------------- | -------------------------------------------------------------------- | ----- |
| `kubeVersion`       | Force target Kubernetes version (using Helm capabilities if not set) | `""`  |
| `nameOverride`      | String to partially override horizon.fullname                        | `""`  |
| `fullnameOverride`  | String to fully override horizon.fullname                            | `""`  |
| `commonLabels`      | Labels to add to all deployed objects                                | `{}`  |
| `commonAnnotations` | Annotations to add to all deployed objects                           | `{}`  |


### Horizon deployment parameters

| Name                                    | Description                                                                               | Value                   |
| --------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------- |
| `image.registry`                        | Horizon image registry                                                                    | `registry.evertrust.io` |
| `image.repository`                      | Horizon image repository                                                                  | `horizon`               |
| `image.tag`                             | Horizon image tag (immutable tags are recommended)                                        | `2.0.4`                 |
| `image.pullPolicy`                      | Horizon image pull policy                                                                 | `IfNotPresent`          |
| `image.pullSecrets`                     | Horizon image pull secrets                                                                | `[]`                    |
| `updateStrategy.type`                   | Horizon deployment strategy type                                                          | `RollingUpdate`         |
| `updateStrategy.rollingUpdate`          | Rolling update spec                                                                       | `{}`                    |
| `priorityClassName`                     | Horizon pod priority class name                                                           | `""`                    |
| `hostAliases`                           | Horizon pod host aliases                                                                  | `[]`                    |
| `extraVolumes`                          | Optionally specify extra list of additional volumes for Horizon pods                      | `[]`                    |
| `extraVolumeMounts`                     | Optionally specify extra list of additional volumeMounts for Horizon container(s)         | `[]`                    |
| `sidecars`                              | Add additional sidecar containers to the Horizon pod                                      | `[]`                    |
| `lifecycleHooks`                        | Add lifecycle hooks to the Horizon deployment                                             | `{}`                    |
| `podLabels`                             | Extra labels for Horizon pods                                                             | `{}`                    |
| `podAnnotations`                        | Annotations for Horizon pods                                                              | `{}`                    |
| `podAffinityPreset`                     | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`                    |
| `podAntiAffinityPreset`                 | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`                  |
| `nodeAffinityPreset.type`               | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`                    |
| `nodeAffinityPreset.key`                | Node label key to match. Ignored if `affinity` is set                                     | `""`                    |
| `nodeAffinityPreset.values`             | Node label values to match. Ignored if `affinity` is set                                  | `[]`                    |
| `affinity`                              | Affinity for pod assignment                                                               | `{}`                    |
| `nodeSelector`                          | Node labels for pod assignment                                                            | `{}`                    |
| `tolerations`                           | Tolerations for pod assignment                                                            | `[]`                    |
| `resources.limits`                      | The resources limits for the Horizon container                                            | `{}`                    |
| `resources.requests`                    | The requested resources for the Horizon container                                         | `{}`                    |
| `podSecurityContext.enabled`            | Enabled Horizon pods' Security Context                                                    | `true`                  |
| `podSecurityContext.fsGroup`            | Set Horizon pod's Security Context fsGroup                                                | `1001`                  |
| `containerSecurityContext.enabled`      | Enabled Horizon containers' Security Context                                              | `true`                  |
| `containerSecurityContext.runAsUser`    | Set Horizon container's Security Context runAsUser                                        | `1001`                  |
| `containerSecurityContext.runAsNonRoot` | Set Horizon container's Security Context runAsNonRoot                                     | `true`                  |
| `livenessProbe.enabled`                 | Enable livenessProbe                                                                      | `true`                  |
| `livenessProbe.initialDelaySeconds`     | Initial delay seconds for livenessProbe                                                   | `90`                    |
| `livenessProbe.periodSeconds`           | Period seconds for livenessProbe                                                          | `10`                    |
| `livenessProbe.timeoutSeconds`          | Timeout seconds for livenessProbe                                                         | `5`                     |
| `livenessProbe.failureThreshold`        | Failure threshold for livenessProbe                                                       | `6`                     |
| `livenessProbe.successThreshold`        | Success threshold for livenessProbe                                                       | `1`                     |
| `readinessProbe.enabled`                | Enable readinessProbe                                                                     | `true`                  |
| `readinessProbe.initialDelaySeconds`    | Initial delay seconds for readinessProbe                                                  | `60`                    |
| `readinessProbe.periodSeconds`          | Period seconds for readinessProbe                                                         | `5`                     |
| `readinessProbe.timeoutSeconds`         | Timeout seconds for readinessProbe                                                        | `3`                     |
| `readinessProbe.failureThreshold`       | Failure threshold for readinessProbe                                                      | `3`                     |
| `readinessProbe.successThreshold`       | Success threshold for readinessProbe                                                      | `1`                     |
| `customLivenessProbe`                   | Custom livenessProbe that overrides the default one                                       | `{}`                    |
| `customReadinessProbe`                  | Custom readinessProbe that overrides the default one                                      | `{}`                    |
| `horizontalAutoscaler.enabled`          | Enable Horizontal POD autoscaling for Horizon                                             | `false`                 |
| `horizontalAutoscaler.minReplicas`      | Minimum number of Horizon replicas                                                        | `1`                     |
| `horizontalAutoscaler.maxReplicas`      | Maximum number of Horizon replicas                                                        | `3`                     |
| `horizontalAutoscaler.targetCPU`        | Target CPU utilization percentage                                                         | `50`                    |
| `horizontalAutoscaler.targetMemory`     | Target Memory utilization percentage                                                      | `50`                    |
| `disruptionBudget.enabled`              | Created a PodDisruptionBudget                                                             | `false`                 |
| `disruptionBudget.minAvailable`         | Min number of pods that must still be available after the eviction                        | `1`                     |
| `disruptionBudget.maxUnavailable`       | Max number of pods that can be unavailable after the eviction                             | `0`                     |
| `environment`                           | Extra env vars passed to the Horizon pods                                                 | `[]`                    |


### Horizon Service configuration

| Name                               | Description                                                       | Value       |
| ---------------------------------- | ----------------------------------------------------------------- | ----------- |
| `service.type`                     | Kubernetes service type                                           | `ClusterIP` |
| `service.clusterIP`                | Horizon service clusterIP IP                                      | `""`        |
| `service.loadBalancerIP`           | loadBalancerIP for the Horizon Service (optional, cloud specific) | `""`        |
| `service.loadBalancerSourceRanges` | Address that are allowed when service is LoadBalancer             | `[]`        |
| `service.externalTrafficPolicy`    | Enable client source IP preservation                              | `Cluster`   |
| `service.annotations`              | Annotations for Horizon service                                   | `{}`        |


### Horizon Ingress configuration

| Name                       | Description                                                                                                                      | Value   |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `ingress.enabled`          | Set to true to enable ingress record generation                                                                                  | `false` |
| `ingress.ingressClassName` | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`    |
| `ingress.annotations`      | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`    |
| `ingress.hosts`            | Routing configuration for the ingress                                                                                            | `[]`    |
| `ingress.tls`              | Enable TLS configuration for the ingress                                                                                         | `[]`    |


### Horizon application parameters

| Name                  | Description                                                     | Value                                                                             |
| --------------------- | --------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `appSecret`           | Application secret used for encrypting session data and cookies | `{}`                                                                              |
| `license.secretName`  | Existing secret name where the Horizon license is stored        | `""`                                                                              |
| `license.secretKey`   | Existing secret key where the Horizon license is stored         | `""`                                                                              |
| `vaults`              | Horizon vaults configuration                                    | `[]`                                                                              |
| `vault.configuration` | Name of the vault used for configuration purposes               | `default`                                                                         |
| `vault.escrow`        | Name of the vault used for escrowing purposes                   | `default`                                                                         |
| `vault.transient`     | Name of the vault used for storing transient keys               | `default`                                                                         |
| `allowedHosts`        | Additional allowed hosts.                                       | `[]`                                                                              |
| `mailer.host`         | SMTP host                                                       | `""`                                                                              |
| `mailer.port`         | SMTP host port                                                  | `587`                                                                             |
| `mailer.tls`          | Enable TLS for this SMTP host                                   | `true`                                                                            |
| `mailer.ssl`          | Enable SSL for this SMTP host                                   | `false`                                                                           |
| `mailer.user`         | Authentication username for this SMTP host                      | `""`                                                                              |
| `mailer.password`     | Authentication password for this SMTP host                      | `{}`                                                                              |
| `logback.level`       | Global level below wich messages will not be logged             | `DEBUG`                                                                           |
| `logback.pattern`     | Log messages pattern                                            | `%date{yyyy-MM-dd HH:mm:ss} - [%logger] - [%level] - %message%n%xException{full}` |
| `logback.loggers`     | Enabled loggers in the `name: LEVEL` format                     | `{}`                                                                              |


### Database parameters

| Name                                | Description                                                                       | Value                                                                                                        |
| ----------------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `mongodb.enabled`                   | Set this to true to install a local MongoDB instance                              | `true`                                                                                                       |
| `mongodb.database`                  | Database name to use when using a local MongoDB instance                          | `horizon`                                                                                                    |
| `mongodb.fullnameOverride`          | Local MongoDB installation name                                                   | `horizon-mongodb`                                                                                            |
| `externalDatabase.uri`              | External MongoDB URI. If set, this will override the `mongodb.enabled` parameter. | `{}`                                                                                                         |
| `externalDatabase.initDatabase`     | Set this to true to create an administrator user                                  | `true`                                                                                                       |
| `externalDatabase.initUsername`     | Username used when initializing the database                                      | `administrator`                                                                                              |
| `externalDatabase.initPasswordHash` | Password hash used when initializing the database. Default: horizon               | `$6$8JDCzmb9XDpOwtGQ$7.kRdgIjPYR/AxPbzKsdkBH3ouCgFbqyH9csjcr5qIoIXK/f2L6bQYQRhi9sdQM4eBm8sGUdEkg.TVOQ1MRsA/` |


