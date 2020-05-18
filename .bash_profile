# {{{ Load modules
for f in ~/.{aliases,exports,scripts}; do
        [[ -r "$f" ]] && source "$f";
done;
unset f;
# }}}

# Set prompt
PS1='[\u@\h \W]\$ '
