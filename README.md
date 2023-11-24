# vscode-settings

## Dependencies

- [Node.js](https://nodejs.org/) (`npm` & `npx`)
- [Anacron](https://anacron.sourceforge.net/)

This repository holds my VSCode settings, extensions, keybindings, and profiles.

On Linux, this corresponds to the `~/.config/Code/User` directory.

The default profile's extensions is imported by [`scripts/sync_default_extensions.sh`](./scripts/sync_default_extensions.sh), because the default `extensions.json` is located outside of this directory (`~/.vscode/extensions/extensions.json`).

Use [`scripts/push_changes.sh`](./scripts/push_changes.sh) to manually push local changes to the repository.

Use [`scripts/setup_cron_job.sh`](./scripts/setup_cron_job.sh) to setup a weekly cronjob. Be careful because [`scripts/run_cron_job.sh`](./scripts/run_cron_job.sh) contains an Ubuntu-specific hack to load the PATH from `.bashrc` (strips the first 10 lines before loading it, see link in script).

The logs for the cron job will be located at `~/.var/logs/cron.weekly/vscode_settings_push_changes.logs` (overwritten on every run).

Example run logs:

```console
$ cat ~/.var/logs/cron.weekly/vscode_settings_push_changes.logs
=====> Syncing default extensions to /home/sherlox/.config/Code/User ...
=====> Installing dependencies & setting up git hook ...
husky - Git hooks installed
=====> Running formatter ...
.prettierrc 49ms (unchanged)
extensions.json 55ms
keybindings.json 6ms (unchanged)
package-lock.json 15ms (unchanged)
package.json 1ms (unchanged)
profiles/327224a3/extensions.json 30ms (unchanged)
profiles/327224a3/keybindings.json 3ms (unchanged)
profiles/327224a3/settings.json 2ms (unchanged)
profiles/7216695c/extensions.json 30ms
profiles/7216695c/keybindings.json 3ms (unchanged)
profiles/7216695c/settings.json 2ms (unchanged)
README.md 33ms (unchanged)
settings.json 7ms (unchanged)
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
[main 774f41e] chore: sync changes
 1 file changed, 25 insertions(+)
To github.com:sheerlox/vscode-settings.git
   1268dc7..774f41e  main -> main
=====> Done.
```
