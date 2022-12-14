# provider.tf
terraform {
  required_version = ">= 0.13"

  required_providers {
    flexibleengine = {
      source = "FlexibleEngineCloud/flexibleengine"
      version = ">= 1.34.0"
      
    }
  }
}

provider "flexibleengine" {
  access_key  = "FNYMVPOPUCS3FQDRRZTJ"
  secret_key  = "cJ3cUiA63tVoRSvoip8VTP3NoinFaSX64hMCOfHF"
  domain_name = "OCB0001686"
  region      = "eu-west-0"
  tenant_name = "eu-west-0_workspace_demo"
  auth_url    = "https://iam.eu-west-0.prod-cloud-ocb.orange-business.com/v3"
  insecure = true
}


resource "flexibleengine_compute_instance_v2" "instance" { #le parametre instance est tres important et correspond au job terraform si on le chance ca detruit et cree une autre instance
  name            = "test_cbard"
  image_id        = "c2280a5f-159f-4489-a107-7cf0c7efdb21" #Ubuntu 20.04
  flavor_id       = "s3.large.2"
  key_pair        = "KeyPair-cbard"
  security_groups = ["sg-cbard"]

  network {
    uuid = "d4e3705f-2908-4fd1-8fd7-ace2d85708c6"
  }

  tags = {
    owner  = "cbard"
  }
}
