module "Instance_Launch"{
    source="../Single-Server_Launch"
    ami=var.ami["${var.region}"]
    instance=var.instance
    
}