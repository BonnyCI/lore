# Setup

## Table of Contents

* [Installation](#installation)
* [Hoist Configuration](#hoist-configuration)
  * [Zuul Job Configuration](#zuul-job-configuration)
  * [Zuul Layout Configuration](#zuul-layour-configuration)
* [Merge Options](#merge-options)
  * [Setting the Correct Merge Option](#setting-the-correct-merge-option)

## Integration

BonnyCI makes use of GitHub's [integration feature](https://developer.github.com/early-access/integrations/).
To install it go to the [BonnyCI integration configuration page](https://github.com/integration/bonnyci) and press the "Install" button.
An integration is installed to your user or your organization. You can then select whether to make it available to all repositories or only selected ones.

You may notice here that BonnyCI requests write access to these repositories. This is required for BonnyCI to be able to merge pull requests on your repositories.

## Hoist Configuration

We'll need some configuration changes in [hoist](https://github.com/BonnyCI/hoist) for your project to gain the necessary Zuul testing queues. Follow our [contribution lore](https://github.com/BonnyCI/lore/tree/master/developers/contributing) for getting these files updated.

### Zuul Job Configuration

This file will add a definition for what tests to run on your repository with BonnyCI. Place it in `hoist/roles/zuul/files/jobs/repo_name.yaml`. Here is a sample configuration:

```YAML
- job:
    name: unique_job_name
    node: 'ubuntu-xenial'

    builders:
      - zuul-git-prep
      - shell: |
          #!/bin/bash -xe
          ./path/to/script/in/your/repo.sh

    publishers:
      - console-log
```

### Zuul Layout Configuration

Now that we have defined what tests will run on your project, we need to ensure that BonnyCI will actually run them. Edit `hoist/roles/zuul/templates/etc/zuul/config/layout.yaml` and add an entry in the `projects:` list for your project. Ensure it is in alphabetical order. Here is a sample configuration:

```YAML
projects:
  ...

  - name: unique_job_name
    check_github:
      - name_of_job_config_file
    gate_github:
      - name_of_job_config_file

  ...
```

## Merge Options

Repositories that use BonnyCI should not use any merge strategy which changes the SHA of the commit. This is because [zuul](https://github.com/openstack-infra/zuul), the scheduler used in BonnyCI, will be thrown off by the change in SHA if multiple changes are running in the gate. BonnyCI tests the changes in the pull requests without altering them. To ensure that which is tested is what is merged, do not enable a merge strategy that would alter the pull request content upon merging it.

GitHub presents repository owners with 3 choices for what happens when merging a pull request:

* Create a merge commit
* Squash and merge
* Rebase and merge

For more on these options and what they mean, read the [documentation on merge methods](https://help.github.com/articles/about-merge-methods-on-github/) provided by GitHub.

### Setting the Correct Merge Option

In order for BonnyCI to function correctly, please only allow merge commits. From your repository's home page, navigate to the `Settings` tab. Scroll down to the section labeled `Merge button`, and ensure that it matches the following:

![Correct Merge Button Configuration](../../misc/images/mergebutton.png)
