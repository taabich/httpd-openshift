oc delete all -l app=ansible-server
oc delete template ansible-template
oc delete  persistentvolumeclaims pv-ansible-data
oc delete  persistentvolume pv-ansibke
oc delete sc  sa-ansible
oc create -f ansible.yaml
oc new-app ansible-template --env-file=env-ansible.properties
oc create sa sa-ansible
oc adm policy add-scc-to-user anyuid -z sa-ansible
oc adm policy add-scc-to-user anyuid -z sa-ansible -n oc-project
oc set sa deployment ansible-server sa-ansible
#oc scale deploy ansible-server --replicas=1