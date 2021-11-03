# Desk

This is intended to be very much like a git repo, except that it's for bigger,
often opaque files that don't play well with git.

For example, image files aren't git-friendly. They're big and binary, and I only
really care about the latest versions of them.

## Setup

1. Install [awscli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
2. Copy `.env.example` to `.env` and set the variables.

## Syncing

```bash
# Does a dry run before asking confirmation to override.
./sync-up.sh

# Does a dry run before asking confirmation to override.
./sync-down.sh

# Copy just one file to the remote bucket in order to surgically correct
# conflicts.
./cp-up.sh
```

TODO: Write a `sync.sh` script that figures out automatically which direction to
sync and provides a way to resolve conflicts.
