# To avoid this error:
# objc[16412]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called.
# objc[16412]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called. We cannot safely call it or ignore it in the fork() child process. Crashing instead. Set a breakpoint on objc_initializeAfterForkError to debug.

export PGGSSENCMODE="disable" # if this doesn't work, use "false"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# export SPRING_LOG=/dev/fd/2
