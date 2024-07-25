# Tomcat example


httpd --- (AJP) ---> Tomcat




### Build

On OpenShift

```
oc new-project tomcat \
    --description="Examples - tomcat, httpd" \
    --display-name="Examples"

oc create -f tomcat/BuildConfig.yaml
oc create -f tomcat/Deployment.yaml
oc create -f tomcat/Services.yaml
oc start-build tomcat
```

