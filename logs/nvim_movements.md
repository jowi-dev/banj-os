

## Window management
Tmux doesn't need to be the way we manage windows. 
:h buffer has a pretty complete list of ways to create buffers
with even more flexibility than tmux. Things needed to adopt:
- Way to create tab
  * keybinding: test
  test again
  test



### Enhancement plan
- remove tmux
- requirements 
  * ability to navigate between buffers easily
  * ability to create new split windows in vim
  * ability to create new tab pages in vim
  * ability to create and restore sessions in vim
  * ability to pass commands between buffers/tabs in vim


1. ability to navigate between buffers easily in vim
- buffers in the same window - CTRL+W, arrows
- tabpages - `gt`

2. ability to create split windows in vim
- vertical split - CTRL + W v
- horizontal split - CTRL + W s
- make current window the only one - CTRL + W o

3. ability to create new tab pages in vim
- new tab page - CTRL + W T

4. ability to create and restore sessions in vim
- :mksession config.session
* this will make a session (config.session) will be the file it is saved in
PROBLEM - need to rebind keys for moving in and out of terminal mode so
it isn't blocked on windows, or rebind 1password defaults
QUESTION - how to make all sessions discoverable ?

BONUS. Window movement
- CTRL-W JKHL for moving down, up, left, right respectively



