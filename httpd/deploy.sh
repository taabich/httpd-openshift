oc delete all -l app=httpd-server
oc delete template httpd-template
oc delete  persistentvolumeclaims pv-httpd-data
oc delete  persistentvolume pv-httpd
oc create -f httpd.yaml
oc new-app httpd-template --env-file=env-httpd.properties
oc create sa sa-httpd
oc adm policy add-scc-to-user anyuid -z sa-httpd
oc adm policy add-scc-to-user anyuid -z sa-httpd -n oc-project
oc set sa deployment httpd-server sa-httpd
oc scale deploy httpd-server --replicas=1