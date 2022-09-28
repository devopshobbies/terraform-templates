output "hostnames-ips" {
  value = [
    for index, v in arvan_iaas_network_attach.private-network-attach :
    { "server-ip" : v.ip,
      "server-name" : module.abrak-module[index].details-myabrak-id.name
    }
  ]


}

