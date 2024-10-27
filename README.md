# My Dotfiles

## Installation

Follow these steps to install the dotfiles using Ansible:

**Run the Ansible playbook**:

```sh
ansible-playbook ./bootstrap.yml --ask-become-pass
```

The `--ask-become-pass` flag is used to prompt for the sudo password if any tasks require elevated privileges.
