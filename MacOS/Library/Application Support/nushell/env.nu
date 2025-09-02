# env.nu

# Import the helper to prepend entries to $PATH
use std/util "path add"

# Add `brew` itself on $PATH`
path add "/opt/homebrew/bin"
path add "/opt/homebrew/sbin"

# Capture Homebrew‑Python’s libexec/bin dir name that always changes based on version.
path add (
  /opt/homebrew/bin/brew --prefix python                 # prints e.g. /opt/homebrew/Cellar/python@3.11/3.11.4
  | str trim                                             # remove trailing newline               :contentReference[oaicite:1]{index=1}
  | path split                                           # split into ["", "opt", "homebrew", …] :contentReference[oaicite:2]{index=2}
  | path join "libexec" "bin"                            # append the libexec/bin components    :contentReference[oaicite:3]{index=3}
)

# ────── LLVM (keg-only) setup ──────

# Make llvm binaries (clang, clang++, etc.) available first
path add "/opt/homebrew/opt/llvm/bin"

# LLD
path add "/opt/homebrew/opt/lld/bin"

# Brew
$env.HOMEBREW_AUTO_UPDATE_SECS = "120"

# Tell compilers where to find LLVM’s headers and libs
$env.CPPFLAGS = "-I/opt/homebrew/opt/llvm/include"
$env.LDFLAGS  = "-L/opt/homebrew/opt/llvm/lib"

# Point clang at custom config dirs
$env.CLANG_CONFIG_FILE_SYSTEM_DIR = "/opt/homebrew/etc/clang"
$env.CLANG_CONFIG_FILE_USER_DIR   = "~/.config/clang"

# Java
$env.CPPFLAGS = "-I/opt/homebrew/opt/openjdk/include"


# ────── Other PATH entries ──────

# Other PATH entries
path add "/bin"
path add "/opt/local/bin"
path add "/opt/local/sbin"
path add "~/.cargo/bin"
path add "~/.local/bin"
path add "/opt/homebrew/opt/openjdk/bin"

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
# $env.PIP_REQUIRE_VIRTUALENV = "true"

# GPG
$env.GIT_GPG_COMMAND = "gpg --pinentry-mode=loopback"
$env.GPG_TTY = (tty)

# Vulkan
$env.VK_ICD_FILENAMES = "/opt/homebrew/opt/vulkan-tools/lib/mock_icd/VkICD_mock_icd.json"

# Nushell
$env.config.buffer_editor = "/opt/homebrew/bin/nvim"
$env.config.show_banner = false

source "~/.cargo/env.nu"
