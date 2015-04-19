# coding: utf-8
import cloudmesh
start_txt = cloudmesh.shell("vm start --cloud=india --image=futuresystems/ubuntu-14.04 --flavor=m1.small")
terminate_txt = cloudmesh.shell("vm delete --cloud=india hshioi_7 --force")
f = open('hshioi_cloudmesh_ex3.txt','w')
f.write(str(start_txt)+"\n"+str(terminate_txt) )
f.close()
