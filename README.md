# hpecp-tutorialbox-demo


The HPE Container Platform Tutorialbox is an Interactive way to get familiar with the HPE Container Platform and the included Data Fabric. The Goal for the Tutorial Box is to provide different Personas including Data Engineers, Data Scientists, App Developers and Operators some examples for getting familiar with the Platform.

The Container Images includes a Jupyter Lab Environment with all the necessary admin utilies to connect to the HPE Container Platform and MapR Data Fabric 


### Build the Tutorial Box Container
```
git clone https://github.com/hpe-container-platform-community-demos/hpecp-tutorialbox-demo
cd hpecp-tutorialbox-demo/hpecp-tutorialbox-container
build -t hpecp-tutorialbox . 
```
### Start the Tutorial Box Container
```
docker run -d -p 8899:8888 --name hpecp-tutorialbox hpecp-tutorialbox:latest
```

### Access the URL 
Default Password is the Jupyter Notebook is hpecp
```
open the URL in a Browser http://locahost:8899
```


### Remove the running container
```
docker rm -f hpecp-tutorialbox
```
