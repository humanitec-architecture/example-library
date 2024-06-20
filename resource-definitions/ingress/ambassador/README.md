## Using the Ambassador Ingress Controller

This section contains example Resource Definitions for the [Ambassador Ingress Controller](https://www.getambassador.io/docs/emissary/latest/topics/running/ingress-controller) using the [Mapping custom resource definition](https://www.getambassador.io/docs/edge-stack/latest/topics/using/intro-mappings) for handling Kubernetes ingress traffic.
Instead of the drver type `ingress`, we are using the `template` driver type, which allows us to render any kuberentes yaml object. 

* [ingress-ambassador.yaml](ingress-ambassador.yaml): defines a `Mapping` object for the Ambassador Ingress Controller. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)