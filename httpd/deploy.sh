oc delete all -l app=httpd-server
oc delete template httpd-template
oc delete  persistentvolumeclaims pv-httpd-data
oc delete  persistentvolume pv-httpd
oc create -f httpd.yaml
oc new-app httpd-template --env-file=env-httpd.properties
