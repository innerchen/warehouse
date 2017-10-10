#!/usr/bin/env zsh
# #
# # #README
# #
# # This theme provides two customizable header functionalities:
# # a) displaying a pseudo-random message from a database of quotations
# # (https://en.wikipedia.org/wiki/Fortune_%28Unix%29)
# # b) displaying randomly command line tips from The command line fu
# # (http://www.commandlinefu.com) community: in order to make use of this functionality
# # you will need Internet connection.
# # This theme provides as well information for the current user's context, like;
# # branch and status for the current version control system (git and svn currently
# # supported) and time, presented to the user in a non invasive volatile way.
# #
# # #REQUIREMENTS
# # This theme requires wget::
# # -Homebrew-osx- brew install wget
# # -Debian/Ubuntu- apt-get install wget
# # and fortune ::
# # -Homebrew-osx- brew install fortune
# # -Debian/Ubuntu- apt-get install fortune
# #
# # optionally:
# # -Oh-myzsh vcs plug-ins git and svn.
# # -Solarized theme (https://github.com/altercation/solarized/)
# # -OS X: iTerm 2 (http://www.iterm2.com/)
# # -font Source code pro (https://github.com/adobe/source-code-pro)
# #
# # This theme's look and feel is based on the Aaron Toponce's zsh theme, more info:
# # http://pthree.org/2008/11/23/727/
# # enjoy!
########## COLOR ###########
for COLOR in CYAN WHITE YELLOW MAGENTA BLACK BLUE RED DEFAULT GREEN GREY; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{$reset_color%}"
RED_START="${PR_RESET}${PR_GREY}<${PR_RESET}${PR_RED}<${PR_BRIGHT_RED}<${PR_RESET} "
RED_END="${PR_RESET}${PR_BRIGHT_RED}>${PR_RESET}${PR_RED}>${PR_GREY}>${PR_RESET} "
GREEN_END="${PR_RESET}${PR_BRIGHT_GREEN}>${PR_RESET}${PR_GREEN}>${PR_GREY}>${PR_RESET} "
WHITE_BASE_START="${PR_RESET}>${PR_RESET}"
WHITE_START_P1="${PR_RESET}${WHITE_BASE_START}${PR_RESET} "
DIVISION="${PR_RESET}${PR_RED} < ${PR_RESET}"
VCS_DIRTY_COLOR="${PR_RESET}${PR_YELLOW}"
VCS_CLEAN_COLOR="${PR_RESET}${PR_GREEN}"
VCS_SUFIX_COLOR="${PR_RESET}${PR_RED}› ${PR_RESET}"
# ########## COLOR ###########
# ########## SVN ###########
ZSH_THEME_SVN_PROMPT_PREFIX="${PR_RESET}${PR_RED}‹svn:"
ZSH_THEME_SVN_PROMPT_SUFFIX=""
ZSH_THEME_SVN_PROMPT_DIRTY="${VCS_DIRTY_COLOR} ✘${VCS_SUFIX_COLOR}"
ZSH_THEME_SVN_PROMPT_CLEAN="${VCS_CLEAN_COLOR} ✔${VCS_SUFIX_COLOR}"
# ########## SVN ###########
# ########## GIT ###########
ZSH_THEME_GIT_PROMPT_PREFIX="${PR_RESET}${PR_RED}‹git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="${VCS_DIRTY_COLOR} ✘${VCS_SUFIX_COLOR}"
ZSH_THEME_GIT_PROMPT_CLEAN="${VCS_CLEAN_COLOR} ✔${VCS_SUFIX_COLOR}"
ZSH_THEME_GIT_PROMPT_ADDED="${PR_RESET}${PR_YELLOW} ✚${PR_RESET}"
ZSH_THEME_GIT_PROMPT_MODIFIED="${PR_RESET}${PR_YELLOW} ✹${PR_RESET}"
ZSH_THEME_GIT_PROMPT_DELETED="${PR_RESET}${PR_YELLOW} ✖${PR_RESET}"
ZSH_THEME_GIT_PROMPT_RENAMED="${PR_RESET}${PR_YELLOW} ➜${PR_RESET}"
ZSH_THEME_GIT_PROMPT_UNMERGED="${PR_RESET}${PR_YELLOW} ═${PR_RESET}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="${PR_RESET}${PR_YELLOW} ✭${PR_RESET}"
# ########## GIT ###########

# Context: user@directory or just directory
prompt_context () {
    #if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    #    echo -n "${PR_RESET}${PR_RED}$USER@%m${PR_RESET}${PR_BRIGHT_YELLOW}%~%<<${PR_RESET}"
    #else
        echo -n "${PR_RESET}${PR_BRIGHT_BLUE}%~%<<${PR_RESET}"
    #fi
}

set_prompt () {
    # required for the prompt
    setopt prompt_subst
    autoload zsh/terminfo

    # ######### PROMPT #########
    PROMPT='${PROMPT_HEAD}
$(prompt_context)
${WHITE_START_P1}'
    RPROMPT='${PR_RESET}$(git_prompt_info)$(svn_prompt_info)${PR_RESET}[%D{%R.%S}]${PR_RESET}'
    # Matching continuation prompt
    PROMPT2='${GREEN_BASE_START}${PR_RESET} %_ ${GREEN_BASE_START}${PR_RESET} '
    # ######### PROMPT #########
}

set_prompt
