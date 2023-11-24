# vscode-settings

This repository holds my VSCode settings, extensions, keybindings, and profiles.

On Linux, this repository corresponds to the `~/.config/Code/User` directory.

## Dependencies

- [Node.js](https://nodejs.org/) (`npm` & `npx`)
- [Anacron](https://anacron.sourceforge.net/)

## Syncing

The default profile's extensions is imported by [`scripts/sync_default_extensions.sh`](./scripts/sync_default_extensions.sh), because the default `extensions.json` is located outside of this directory (`~/.vscode/extensions/extensions.json`).

Use [`scripts/push_changes.sh`](./scripts/push_changes.sh) to run the above script and push local changes to the git repository.

## Cron job

Use [`scripts/setup_cron_job.sh`](./scripts/setup_cron_job.sh) to setup a weekly cronjob. Be careful because [`scripts/run_cron_job.sh`](./scripts/run_cron_job.sh) contains an Ubuntu-specific hack to load the PATH from `.bashrc` (strips the first 10 lines before loading it, see link in script).

The logs for the cron job will be located at `~/.var/logs/cron.weekly/vscode_settings_push_changes.logs` (overwritten on every run).

### Example cron logs

```console
$ cat ~/.var/logs/cron.weekly/vscode_settings_push_changes.logs
=====> Syncing default extensions to /home/sherlox/.config/Code/User ...
=====> Installing dependencies & setting up git hook ...
husky - Git hooks installed
=====> Running formatter ...
.prettierrc 34ms (unchanged)
extensions.json 29ms
keybindings.json 4ms (unchanged)
package-lock.json 8ms (unchanged)
package.json 1ms (unchanged)
profiles/327224a3/extensions.json 15ms (unchanged)
profiles/327224a3/keybindings.json 2ms (unchanged)
profiles/327224a3/settings.json 1ms (unchanged)
profiles/7216695c/extensions.json 13ms (unchanged)
profiles/7216695c/keybindings.json 2ms (unchanged)
profiles/7216695c/settings.json 1ms (unchanged)
README.md 22ms (unchanged)
settings.json 4ms (unchanged)
=====> Pushing changes in /home/sherlox/.config/Code/User to Git ...
[STARTED] Preparing lint-staged...
[COMPLETED] Preparing lint-staged...
[STARTED] Running tasks for staged files...
[STARTED] package.json — 1 file
[STARTED] *.{json,md} — 1 file
[STARTED] prettier --write
[COMPLETED] prettier --write
[COMPLETED] *.{json,md} — 1 file
[COMPLETED] package.json — 1 file
[COMPLETED] Running tasks for staged files...
[STARTED] Applying modifications from tasks...
[COMPLETED] Applying modifications from tasks...
[STARTED] Cleaning up temporary files...
[COMPLETED] Cleaning up temporary files...
[main ab26854] chore: sync changes
 1 file changed, 24 deletions(-)
To github.com:sheerlox/vscode-settings.git
   e1ce128..ab26854  main -> main
=====> Done.
```
