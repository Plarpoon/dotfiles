# env.nu

# Import the helper to prepend entries to $PATH
use std/util "path add"

# Add `brew` itself on $PATH`
path add "/opt/homebrew/bin"

# Capture Homebrew‑Python’s libexec/bin dir name that always changes based on version.
path add (
  /opt/homebrew/bin/brew --prefix python                 # prints e.g. /opt/homebrew/Cellar/python@3.11/3.11.4
  | str trim                                             # remove trailing newline               :contentReference[oaicite:1]{index=1}
  | path split                                           # split into ["", "opt", "homebrew", …] :contentReference[oaicite:2]{index=2}
  | path join "libexec" "bin"                            # append the libexec/bin components    :contentReference[oaicite:3]{index=3}
)

# Other PATH entries
path add "/bin"
path add "/opt/local/bin"
path add "/opt/local/sbin"
path add "~/.cargo/bin"
path add "~/.local/bin"

# Source the vpn.nu script
source ($nu.default-config-dir | path join 'vpn.nu')

# Source the ccompilesyel.nu script
# source ($nu.default-config-dir | path join 'ccompilesyel.nu')

# Starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
use ~/.cache/starship/init.nu
starship config command_timeout 10000

# PIP will always install in venv
$env.PIP_REQUIRE_VIRTUALENV = "true"

# GPG TTY
$env.GPG_TTY = (tty)

# Nushell
$env.config.buffer_editor = "/opt/homebrew/bin/nvim"
$env.config.show_banner = false

source "~/.cargo/env.nu"
