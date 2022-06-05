# Generic Supernode for Freifunk Communities

This ansible script shows how a supernode can be configured with only the basic setup.

It is highly inspired by the ansible scripts from [Freifunk Hannover](https://github.com/freifunkh/ansible).

## Features

- multi domain
- configurable BATMAN_IV or BATMAN_V
- wireguard + vxlan + batman

## TODO 

- DNS
- monitoring
- ansible secrets
- ...

## Installation

1. configure the host vars in sn01.yml according to your freshly set up VM
2. configure group_vars/all/main.yml according to needed count of domains and features
    * the vx.py can be used to generate th VXLAN VNI tag from the gluon domain_seed
    * each domain is run on a seperate port - i only tested with 51820 - so domain 20
3. renew the secrets for ansible in secrets.yml 
    * `wg genkey > privatekey`
    * `wg pubkey < privatekey > publickey`
4. execute `ansible-playbook playbooks/supernode.yml`
5. create a gluon client which connects to your host
    * `uci set wgpeerselector.sn01.public_key='mypublickey'`
    * `uci set wgpeerselector.sn01.endpoint='192.168.0.159:51820'`
6. create a repo with name peers-wg at host `git_addr`
    1. access the generated `.ssh` key from the auto user 
    2. add the key as a readaccess key the peers-wg repo
    3. delete `wait_for_access.lock` to move on
    4. now the allowed keys are pulled from the repo and are update automatically


This allows to create a mail-based-workflow like "send your key to ... to add it" or create a web worker which commits and deletes keys from the repo automatically.

