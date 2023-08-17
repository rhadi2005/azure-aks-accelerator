module "dev_cluster" {
    source       = "./main"
    env_name     = "dev"
    cluster_name = "rmt-aks-iac"
    instance_type= "standard_d2_v2"
}

module "prod_cluster" {
    source       = "./main"
    env_name     = "prod"
    cluster_name = "rmt-aks-iac"
    instance_type= "standard_d2_v2"

}