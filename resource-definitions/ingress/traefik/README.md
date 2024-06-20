## Using the Traefik Ingress Controller

This section contains example Resource Definitions for the [Traefik Ingress Controller](https://doc.traefik.io/traefik/) using the [IngressRoute custom resource definition](https://doc.traefik.io/traefik/providers/kubernetes-crd/) for handling Kubernetes ingress traffic.
Instead of the drver type `ingress`, we are using the `template` driver type, which allows us to render any kuberentes yaml object. 

* [ingress-traefik.yaml](ingress-traefik.yaml): defines an `IngressRoute` object for the Traefik Ingress Controller. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)