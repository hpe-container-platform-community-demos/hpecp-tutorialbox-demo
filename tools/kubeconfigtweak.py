#!/usr/bin/python3
## K8s config-editor
##
## this tweaks all _kube.conf files. 
import yaml
import os

path = '/home/'+ os.environ['NB_USER'] +'/data/k8sconfig/'

for file in os.listdir(path):
    if file.endswith(".conf"):
        clustername = file[0:file.find("_kube")]
        print("Clustername detected: " + clustername)
        with open(path+file,) as file:
            k8sfile = yaml.load(file, Loader=yaml.FullLoader)
            k8sfile['clusters'][0]['name'] = clustername
            k8sfile['contexts'][0]['name'] = clustername
            k8sfile['contexts'][0]['context']['cluster'] = clustername
            k8sfile['contexts'][0]['context']['user'] = clustername
            k8sfile['current-context'] = clustername
            k8sfile['users'][0]['name'] = clustername
            with open(path + clustername +'_kube.conf', 'w') as file2:
                save = yaml.dump(k8sfile,file2)
                
