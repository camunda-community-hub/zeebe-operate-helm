# Zeebe Operate Helm Chart

This functionality is in beta and is subject to change. The design and code is less mature than official GA features and is being provided as-is with no warranties. Beta features are not subject to the support SLA of official GA features.

## Requirements

* [Helm](https://helm.sh/) >= 2.8.0
* Kubernetes >= 1.8
* Minimum cluster requirements include the following to run this chart with default settings. All of these settings are configurable.
  * Three Kubernetes nodes to respect the default "hard" affinity settings
  * 1GB of RAM for the JVM heap

## Usage notes and getting started

## Installing

* Add the official zeebe helm charts repo
  ```
  helm repo add zeebe https://helm.zeebe.io
  ```
* Install it
  ```
  helm install --name zeebe-operate zeebe/zeebe-operate --set global.zeebe=<YOUR ZEEBE CLUSTER NAME>
  ```

  > Note that you can find the Zeebe Cluster name by doing `kubectl get services` and copy the name of the Zeebe service, which will include the Helm Release name used to install the cluster. 

 ## Configuration
  | Parameter                     | Description                                                                                                                                                                                                                                                                                                                | Default                                                                                                                   |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `zeebe`                 | Zeebe Cluster to connect Operate to                                                                                                                               |                                                                                                            |
| `nodeSelector`          | nodeSelector used to schedule the deployment. i.e. kubernetes.io/arch: amd64                                                                                       |                                                                                                            |
