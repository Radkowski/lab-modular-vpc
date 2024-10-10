# lab-modular-vpc
<br><br>



## Info


The following code deploys a VPC and private subnets according to the specifications outlined in the configuration file. Each subnet can have its own set of tags and a unique CIDR block, which is automatically calculated as part of the VPC's CIDR. Subnets can be deployed in designated availability zones, and the code includes a mechanism to verify if the specified availability zone exists in the selected region.

### List of features:
- [ ] Deploys VPC 
- [ ] Deploys a specified list of subnets within the VPC
- [ ] The VPC is configured using a set of initial parameters:
    - [ ] CIDR associated with the VPC
    - [ ] Set of Tags assigned to the VPC
- [ ] Each subnet can be customized with the following parameters:
    - [ ] Subnet mask (automatically generated based on the VPC CIDR)
    - [ ] Availability zone for deployment (labeled as letters: A, B, C; case-insensitive)
    - [ ] Set of Tags assigned to each individual subnet

<br><br>


## Config file structure

The configuration file is expected to be stored in either `config.yaml` or `config.json`, following their respective formats. If both files are present, the YAML file will be given priority.

<br>

The following config example deploys a VPC with three subnets, using /23, /24, and /25 subnet masks, distributed across two availability zones.

### YAML format
<br>

```yaml
General:
  DeploymentPrefix: "MyVPC"
  Region: "eu-central-1"

Component:
  CIDR: "10.0.0.0/16"
  Tags:
    Name: "MyVPC"
    beta: "value2"
    gamma: "value3"
    
  PrivateSubnets:
    Private1:
      Mask: 23
      AZ: a
      TAGS:
        key1: value1
        key2: value2
        key3: value3
    Private2:
      Mask: 24
      AZ: A
      TAGS:
        key1: value1
        key2: value2
        key3: value3
    Private3:
      Mask: 25
      AZ: b
      TAGS:
        key1: value1
        key2: value2
        key3: value3
```
<br><br>

### JSON format
<br>

```json
{
  "General": {
    "DeploymentPrefix": "MyVPC",
    "Region": "eu-central-1"
  },
  "Component": {
    "CIDR": "10.0.0.0/16",
    "Tags": {
      "Name": "MyVPC",
      "beta": "value2",
      "gamma": "value3"
    },
    "PrivateSubnets": {
      "Private1": {
        "Mask": 23,
        "AZ": "a",
        "TAGS": {
          "key1": "value1",
          "key2": "value2",
          "key3": "value3"
        }
      },
      "Private2": {
        "Mask": 24,
        "AZ": "A",
        "TAGS": {
          "key1": "value1",
          "key2": "value2",
          "key3": "value3"
        }
      },
      "Private3": {
        "Mask": 25,
        "AZ": "b",
        "TAGS": {
          "key1": "value1",
          "key2": "value2",
          "key3": "value3"
        }
      }
    }
  }
}
```
<br><br>

### Parameters description

- [ ] ***General***: General deployment parameters
    - [ ] ***Region***: Region of deployment

- [ ] ***Component***: Component specific section 
    - [ ] ***CIDR***: CIDR associated with the VPC
    - [ ] ***Tags***: Tags attached to VPC

- [ ] ***Component->PrivateSubnets***: Specification of subnets to be deployed. Each section includes the following parameters:

    - [ ] ***Mask***: The size of the CIDR assigned to each subnet. The number indicates the IP mask, for example:
        * 24 = /24 or 255.255.255.0
        * 28 = /28 or 255.255.255.240

    - [ ] ***AZ***:  A case-insensitive identifier for the availability zone (the last letter) where the subnets will be deployed, for example (in the eu-central-1 Region): 
        * a = eu-central-1a
        * B = eu-central-1b
        * c = eu-central-1c

    - [ ] ***TAGS***:  A list of tags (key/value pairs) assigned to the subnet.

<br><br>