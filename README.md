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
helm install horizon evertrust/horizon
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

> **Warning**: Always store auto-generated secrets in a safe place after they're generated. If you ever uninstall your Helm chart, the deletion of the SSV secret will lead to the impossibility of recovering most of your data.

### Database
When installing the chart, you face multiple options regarding your database :

- By default, a local MongoDB standalone instance will be spawned in your cluster, using the [`bitnami/mongodb`](https://github.com/bitnami/charts/tree/master/bitnami/mongodb) chart. No additional configuration is required but it is not production ready.
- If you want to use an existing MongoDB instance, provide the `externalDatabase.uri` value. The URI should be treated as a secret as it must include credentials.

## Upgrading
We recommended that you only change values you need to customize in your `values.yml` file to ensure smooth upgrading.
Always check the upgrading instructions between chart versions.

### Upgrading the database
When upgrading Horizon, you'll need to run a migration script against the MongoDB database.
The chart will automatically create a `Job` that runs that upgrade script each time you upgrade your release if  `upgrade.enabled` is set to `true`.

> **Note**: if the upgrade job fails to run, check the job's pod logs. When upgrading from an old version of Horizon, you may need to explicitly specify the version you're upgrading from using the `upgrade.from` key. 
> 
### Specific chart upgrade instructions

#### Upgrading to 0.3.0

- Loggers are now configured with an array instead of a dictionary. Check the `values.yaml` format and update your override `values.yaml` accordingly.
- The init dabatabase parameters (`initDatabase`, `initUsername` and `initPassword`) have been renamed and moved to `mongodb.horizon`. 

## Advanced

### Leases
To ensure clustering issues get resolved as fast as possible, Horizon can use a CRD (Custom Resource Definition) named `Lease` (`akka.io/v1/leases`). We strongly recommend that you use this mechanism, however it implies that you have the necessary permissions to install CRDs onto your server. In case you don't, the feature can be disabled by passing the `--skip-crds` flag to the Helm command when installing the chart, and setting the `leases.enabled` key to `false`.
If you want to manually install the CRD, you can check the [leases.yml](crds/leases.yml) file.

### Running behind a Docker registry proxy
If your installation environment requires you to whitelist images that can be pulled by the Kubernetes cluster, you must whitelist the `registry.evertrust.io/horizon` and `registry.evertrust.io/horizon-upgrade` images.

### Injecting extra configuration
Extra Horizon configuration can be injected to the bundled `application.conf` file to modify low-level behavior of Horizon. This should be used carefully as it may cause things to break. To do so, just mount a folder in the Horizon container at `/horizon/etc/conf.d/` containing a `custom.conf` file.

This can be done with the following edits to your `values.yaml` file :
```yaml
extraVolumes:
  - name: additional-config
    configMap:
      name: additional-config

extraVolumeMounts:
  - name: additional-config
    mountPath: /horizon/etc/conf.d
```
Where the `additional-config` configmap contains a single key with your custom configuration :
```yaml
apiVersion: v1
kind: ConfigMap
data:
  custom.conf: |-
    play.server.http.port = 9999
```
Extra configurations are included at the end of the config file, overriding any previously set config value.

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
| `image.tag`                             | Horizon image tag (immutable tags are recommended)                                        | `2.2.1`                 |
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
| `livenessProbe.initialDelaySeconds`     | Initial delay seconds for livenessProbe                                                   | `0`                     |
| `livenessProbe.periodSeconds`           | Period seconds for livenessProbe                                                          | `10`                    |
| `livenessProbe.timeoutSeconds`          | Timeout seconds for livenessProbe                                                         | `5`                     |
| `livenessProbe.failureThreshold`        | Failure threshold for livenessProbe                                                       | `3`                     |
| `livenessProbe.successThreshold`        | Success threshold for livenessProbe                                                       | `1`                     |
| `startupProbe.enabled`                  | Enable startupProbe. Since Horizon is slow to start, this is highly recommended.          | `true`                  |
| `startupProbe.periodSeconds`            | Period seconds for startupProbe                                                           | `3`                     |
| `startupProbe.failureThreshold`         | Failure threshold for startupProbe                                                        | `60`                    |
| `readinessProbe.enabled`                | Enable readinessProbe                                                                     | `true`                  |
| `readinessProbe.initialDelaySeconds`    | Initial delay seconds for readinessProbe                                                  | `0`                     |
| `readinessProbe.periodSeconds`          | Period seconds for readinessProbe                                                         | `5`                     |
| `readinessProbe.timeoutSeconds`         | Timeout seconds for readinessProbe                                                        | `3`                     |
| `readinessProbe.failureThreshold`       | Failure threshold for readinessProbe                                                      | `3`                     |
| `readinessProbe.successThreshold`       | Success threshold for readinessProbe                                                      | `1`                     |
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

| Name                      | Description                                                                                                                           | Value                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `appSecret`               | Application secret used for encrypting session data and cookies                                                                       | `{}`                                                                              |
| `license.secretName`      | Existing secret name where the Horizon license is stored                                                                              | `""`                                                                              |
| `license.secretKey`       | Existing secret key where the Horizon license is stored                                                                               | `""`                                                                              |
| `vaults`                  | Horizon vaults configuration                                                                                                          | `[]`                                                                              |
| `vault.configuration`     | Name of the vault used for configuration purposes                                                                                     | `default`                                                                         |
| `vault.escrow`            | Name of the vault used for escrowing purposes                                                                                         | `default`                                                                         |
| `vault.transient`         | Name of the vault used for storing transient keys                                                                                     | `default`                                                                         |
| `allowedHosts`            | Additional allowed hosts.                                                                                                             | `[]`                                                                              |
| `trustedProxies`          | Trusted proxies.                                                                                                                      | `[]`                                                                              |
| `events.chainsign`        | Whether Horizon events should be signed and chained using the event seal secret.                                                      | `true`                                                                            |
| `events.secret`           | Secret used to sign and chain events.                                                                                                 | `{}`                                                                              |
| `events.ttl`              | Duration during which events are kept in database.                                                                                    | `90 days`                                                                         |
| `events.discoveryTtl`     | Duration during which discovery events are kept in database.                                                                          | `30 days`                                                                         |
| `mailer.host`             | SMTP host                                                                                                                             | `""`                                                                              |
| `mailer.port`             | SMTP host port                                                                                                                        | `587`                                                                             |
| `mailer.tls`              | Enable TLS for this SMTP host                                                                                                         | `true`                                                                            |
| `mailer.ssl`              | Enable SSL for this SMTP host                                                                                                         | `false`                                                                           |
| `mailer.user`             | Authentication username for this SMTP host                                                                                            | `""`                                                                              |
| `mailer.password`         | Authentication password for this SMTP host                                                                                            | `{}`                                                                              |
| `logback.level`           | Global level below wich messages will not be logged                                                                                   | `debug`                                                                           |
| `logback.pattern`         | Log messages pattern                                                                                                                  | `%date{yyyy-MM-dd HH:mm:ss} - [%logger] - [%level] - %message%n%xException{full}` |
| `logback.loggers`         | Enabled loggers and their associated log level                                                                                        | `[]`                                                                              |
| `leases.enabled`          | Whether leases should be used when launching multiple replicas of Horizon pods. This requires the leases.akka.io CRD to be installed. | `true`                                                                            |
| `clientCertificateHeader` | Indicates to Horizon in which header the client certificate will be passed, escaped and pem-encoded.                                  | `Ssl-Client-Cert`                                                                 |


### Database parameters

| Name                           | Description                                                                                                                                                                           | Value                                                                                                        |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `mongodb.enabled`              | Whether to deploy a mongodb server to satisfy the application database requirements. To use an external database set this to false and configure the `externalDatabase.uri` parameter | `true`                                                                                                       |
| `mongodb.architecture`         | MongoDB architecture (`standalone` or `replicaset`)                                                                                                                                   | `standalone`                                                                                                 |
| `mongodb.auth.rootPassword`    | MongoDB admin password                                                                                                                                                                | `""`                                                                                                         |
| `mongodb.auth.username`        | MongoDB custom user                                                                                                                                                                   | `horizon`                                                                                                    |
| `mongodb.auth.database`        | MongoDB custom database                                                                                                                                                               | `horizon`                                                                                                    |
| `mongodb.auth.password`        | MongoDB custom password                                                                                                                                                               | `secret_password`                                                                                            |
| `mongodb.horizon.init`         | Set this to true to initialize the local database for Horizon. This only works when `mongodb.enabled` is set to true.                                                                 | `true`                                                                                                       |
| `mongodb.horizon.username`     | Administration username used when initializing the database                                                                                                                           | `administrator`                                                                                              |
| `mongodb.horizon.passwordHash` | Password hash used when initializing the database. Default: horizon                                                                                                                   | `$6$8JDCzmb9XDpOwtGQ$7.kRdgIjPYR/AxPbzKsdkBH3ouCgFbqyH9csjcr5qIoIXK/f2L6bQYQRhi9sdQM4eBm8sGUdEkg.TVOQ1MRsA/` |
| `upgrade.enabled`              | If true, an upgrade job will be run when upgrading the release, modifying your database schema. This works even if `mongodb.enabled` is set to false.                                 | `false`                                                                                                      |
| `upgrade.image.registry`       | Horizon image registry                                                                                                                                                                | `registry.evertrust.io`                                                                                      |
| `upgrade.image.repository`     | Horizon image repository                                                                                                                                                              | `horizon-upgrade`                                                                                            |
| `upgrade.image.tag`            | Horizon image tag (immutable tags are recommended)                                                                                                                                    | `2.1.1`                                                                                                      |
| `upgrade.image.pullPolicy`     | Horizon image pull policy                                                                                                                                                             | `IfNotPresent`                                                                                               |
| `upgrade.image.pullSecrets`    | Horizon image pull secrets                                                                                                                                                            | `[]`                                                                                                         |
| `upgrade.from`                 | Sets to the version you're upgrading from. If empty, the chart will try to infer the version from the database.                                                                       | `""`                                                                                                         |
| `upgrade.to`                   | Sets the version you're upgrading to. If empty, the chart will use Chart.AppVersion.                                                                                                  | `""`                                                                                                         |
| `externalDatabase.uri`         | External MongoDB URI. For an external database to be used, `mongodb.enabled` must be set to `false`.                                                                                  | `{}`                                                                                                         |


