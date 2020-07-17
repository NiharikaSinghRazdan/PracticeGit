module "stage-instance-launch"{
    source="../../Single-Server_Launch"
    ami=var.ami
    region=var.region
}