# Exersie of "Deploying Virtual Cluster with Cloudmesh "

# Try to access a master node of your cluster. (Make a screenshot)
# Create a Virtual Cluster with 2 VMs. (Make a screenshot)
# Submit two screenshots

# Activate india
cm cloud on india
cm cloud select india
cm cloud default india

# default saetting
cm default image --name=futuresystems/ubuntu-14.04
cm default flavor --name=m1.small


# Create 2 virtual cluster
cm cluster create virtual_cluster_ext --count=2 --ln=ubuntu --cloud=india --flavor=m1.small --image=futuresystems/ubuntu-14.04

# In case many debugging message appear
# cm debug off

#/cloudmesh-2.3.0-py2.7.egg/cloudmesh/iaas/openstack/cm_compute.pyc.

# Setp cluster for Hadoop
cm cloud select india
cm cloud on india
cm key default hshioi-ubuntu-vm-key0510
cm label --prefix=test_hshioi --id=1
cm default image --name=futuresystems/ubuntu-14.04
cm default flavor --name=m1.small


# Deploying Hadoop
#Chef
sudo su -
apt-get update
cd /home/ubuntu
curl -L https://www.opscode.com/chef/install.sh | bash


# Chef configration and Cookbooks
wget http://github.com/opscode/chef-repo/tarball/master
tar -zxf master
mv *-chef-repo* chef-repo
rm master
cd chef-repo/
mkdir .chef
echo "cookbook_path [ '/home/ubuntu/chef-repo/cookbooks' ]" > .chef/knife.rb
cd cookbooks
knife cookbook site download java
knife cookbook site download apt
knife cookbook site download yum
knife cookbook site download hadoop
knife cookbook site download ohai
knife cookbook site download sysctl
tar -zxf java*
tar -zxf apt*
tar -zxf yum*
tar -zxf hadoop*
tar -zxf sysctl*
tar -zxf ohai*
rm *.tar.gz

# Customization for JAVA.rb, hadoop.rb, 
cd /home/ubuntu/chef-repo/roles


nano java.rb
echo "write the below preference in 'java.r'"

# name "java"
# description "Install Oracle Java"
# default_attributes(
#   "java" => {
#     "install_flavor" => "oracle",
#     "jdk_version" => "6",
#     "set_etc_environment" => true,
#     "oracle" => {
#       "accept_oracle_download_terms" => true
#     }
#   }
# )
# run_list(
#   "recipe[java]"
# )

nano hadoop.rb

# name "hadoop"
# description "set Hadoop attributes"
# default_attributes(
#   "hadoop" => {
#     "distribution" => "bigtop",
#     "core_site" => {
#       "fs.defaultFS" => "hdfs://hadoop1"
#     },
#     "yarn_site" => {
#       "yarn.resourcemanager.hostname" => "hadoop1"
#     }
#   }
# )
# run_list(
#   "recipe[hadoop]"
# )

cd /home/ubuntu/chef-repo
nano solo.rb

# file_cache_path "/home/ubuntu/chef-solo"
# cookbook_path "/home/ubuntu/chef-repo/cookbooks"
# role_path "/home/ubuntu/chef-repo/roles"
# verify_api_cert true
