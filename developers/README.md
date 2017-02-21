# Developers

## Table of Contents

* [Contributing](#contributing)
* [Discussion](#discussion)
* [Ansible Environments](#ansible-environments)
  * [Production](#production)
  * [Multinode Nodepool](#multinode-nodepool)
  * [Docker](#docker)
  * [Vagrant](#vagrant)
* [Development Environment](#local-development-environment)
  * [Local Testing](#local-testing)
  * [Personal Cloud Accounts](#personal-cloud-accounts)

## Contributing

Please see the [contributing documentation](contributing) for more information.

A brief note on repository naming...
> The puns get made, or the plank gets walked.
>
> ~Jesse Keating

## Discussion

For discussions about BonnyCI, join us on [freenode](https://freenode.net) #BonnyCi!

## Ansible Environments

The primary ansible playbook in hoist is `./install-ci.yml`, and the result can be validated with the `./tests/validate-ci.yml` playbook.  These playbooks need to support four different environments:

* [Production](#production)
* [Multinode Nodepool](#multinode-nodepool)
* [Docker](#docker)
* [Vagrant](#vagrant)

### Production

A live deployment of [hoist](www.github.com/BonnyCI/hoist) running a CI service, and uses the hoist inventory file `./inventory/ci`.

### Multinode Nodepool

Hoist is tested with a job running on multiple single-use nodepool nodes. The test job deploys hoist on the nodes and validates the result for every pull request. It uses the dynamic inventory script `./inventory/nodepool.py`, and closely resembles production.

### Docker

We have a TravisCI test that deploys hoist in a docker container and validates the result. This uses the `./inventory/allinone` inventory to deploy all components in a single container.

### Vagrant

The Vagrant environment closely resembles production and is only used for [local testing](#local-testing) using the `./inventory/vagrant` inventory.

## Development Environment

Before hacking on BonnyCI, we'll need to set up a development environment on our local or remote machine(s).

Supported development platforms:

* [Ubuntu](dev-environment/ubuntu.md)
* [Apple's macOS](dev-environment/macOS.md)

Additionally, core developers of BonnyCI have access to [personal cloud accounts](#personal-cloud-accounts) on our production cloud which can be used to boot VMs for development and testing purposes.

### Local Testing

You can test changes to BonnyCI locally by exercising some tools defined in [hoist](www.github.com/BonnyCI/hoist). Hoist is a set of ansible playbooks that automate the deployment of a BonnyCI environment. Be sure that you have completed the `Virtualization Tools` section of your OS's [Development Environment](#development-environment) page before proceeding.

To use Vagrant for local testing, refer to [Testing with Vagrant](dev-environment/vagrant.md).

### Personal Cloud Accounts

The BonnyCI project offers personal cloud accounts to core developers. This allows developers to utilize the same cloud environment that our production runs on, for more closely testing changes. Developers who are granted accounts will be provided their own project space, with a fairly limited quota set, as well as `_member_` level rights to our production projects.

Accounts can be requested by creating a pull request to the [Hoist repo](https://github.com/BonnyCI/hoist/), specifically the [create-users-projects.yml](https://github.com/BonnyCI/hoist/blob/master/create-users-projects.yml) playbook. Simply add your details; desired username, email address for contact, and whether or not you'll want `cloud_admin` rights. Once the pull request has been approved, an existing developer with `cloud_admin` rights will execute the playbook to make your account live. A temporary password will be used, which needs to be changed immediately.
