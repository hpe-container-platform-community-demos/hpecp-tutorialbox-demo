mkdir -p /home/${NB_USER}/data/k8sconfig/
CLUSTERS=$(hpecp k8scluster list --columns [id,name]  --output text | sed 1d | tr -s '[:blank:]' ',')
for CLUSTER in $CLUSTERS;
do
    ID=$(echo $CLUSTER | cut -d ',' -f 1)
    NAME=$(echo $CLUSTER | cut -d ',' -f 2)
    hpecp k8scluster admin-kube-config $ID > /home/${NB_USER}/data/k8sconfig/${NAME}_kube.conf
done
unset KUBECONFIG
for i in $(find /home/${NB_USER}/data/k8sconfig/*_kube.conf -maxdepth 0 -type f)
do
         export KUBECONFIG=$KUBECONFIG:${i}
 done
/home/${NB_USER}/data/hpecp-tutorialbox-demo/tools/kubeconfigtweak.py
mkdir -p ~/.kube/
kubectl config view --minify=false --raw=true -o yaml > ~/.kube/config
