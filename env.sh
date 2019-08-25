export EDITOR=vim
if which sccache > /dev/null; then
  export RUSTC_WRAPPER=sccache
fi
