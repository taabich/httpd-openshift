oc delete all -l httpd-server
oc delete template httpd-template
oc delete resourcequotas compute-resources
oc delete limitranges core-resource-limits
oc delete  persistentvolumeclaims pv-httpd-data
oc create -f httpd.yaml
oc new-app httpd-server --env-file=env-httpd.properties
