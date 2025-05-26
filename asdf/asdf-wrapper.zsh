# Wrap asdf to restore 'asdf shell' command for setting version in current shell
# See https://github.com/asdf-vm/asdf/issues/1911#issuecomment-2730315647
# Usage:
#   asdf shell ruby 3.3.6
# Which executes:
#   export ASDF_RUBY_VERSION=3.3.6
asdf() {
	if [[ "$1" == shell ]]; then
		{ set -x; export ASDF_${(U)2}_VERSION=$3; }
	else
		command asdf "$@";
	fi
}
