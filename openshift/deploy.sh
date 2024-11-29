#!/bin/bash -e

# Upload all the user-provided Apache config (overwrite if needed)
oc create configmap apache-userconfig --from-file="apache/" --dry-run=client -o yaml | kubectl apply -f -

# Apply the Kubernetes config
oc apply -f apache.yaml

# Force a rollout to inject the latest Apache config (zero downtime)
oc rollout restart deployment/apache
