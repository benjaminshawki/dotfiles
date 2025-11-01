# Maven inline auto-suggestions for zsh
# Provides real-time suggestions as you type maven commands

typeset -g MAVEN_SUGGEST_ACTIVE=0
typeset -g MAVEN_SUGGEST_TEXT=""

_maven_inline_suggest() {
    local current_buffer="$BUFFER"
    local current_word="${LBUFFER##* }"
    
    # Only suggest for maven commands
    if [[ "$current_buffer" =~ ^(mvn|mvnw|mvnDebug)[[:space:]] ]]; then
        MAVEN_SUGGEST_ACTIVE=1
        
        # Common goal suggestions based on what's being typed
        case "$current_word" in
            cl*)
                MAVEN_SUGGEST_TEXT="clean"
                ;;
            co*)
                MAVEN_SUGGEST_TEXT="compile"
                ;;
            t*)
                MAVEN_SUGGEST_TEXT="test"
                ;;
            p*)
                MAVEN_SUGGEST_TEXT="package"
                ;;
            i*)
                MAVEN_SUGGEST_TEXT="install"
                ;;
            d*)
                MAVEN_SUGGEST_TEXT="deploy"
                ;;
            v*)
                MAVEN_SUGGEST_TEXT="verify"
                ;;
            si*)
                MAVEN_SUGGEST_TEXT="site"
                ;;
            spring*)
                MAVEN_SUGGEST_TEXT="spring-boot:run"
                ;;
            dep*)
                MAVEN_SUGGEST_TEXT="dependency:tree"
                ;;
            -D*)
                # Suggest common properties
                local prop_prefix="${current_word#-D}"
                case "$prop_prefix" in
                    sk*)
                        MAVEN_SUGGEST_TEXT="-DskipTests"
                        ;;
                    maven.t*)
                        MAVEN_SUGGEST_TEXT="-Dmaven.test.skip=true"
                        ;;
                    *)
                        MAVEN_SUGGEST_TEXT=""
                        ;;
                esac
                ;;
            *)
                MAVEN_SUGGEST_TEXT=""
                ;;
        esac
        
        # If we have a suggestion, display it
        if [[ -n "$MAVEN_SUGGEST_TEXT" ]] && [[ "$MAVEN_SUGGEST_TEXT" != "$current_word" ]]; then
            # Calculate the completion
            local completion="${MAVEN_SUGGEST_TEXT#$current_word}"
            if [[ -n "$completion" ]]; then
                # Display suggestion in gray
                POSTDISPLAY=$'\e[90m'"$completion"$'\e[0m'
            else
                POSTDISPLAY=""
            fi
        else
            POSTDISPLAY=""
        fi
    else
        MAVEN_SUGGEST_ACTIVE=0
        POSTDISPLAY=""
    fi
}

_maven_accept_suggest() {
    if [[ $MAVEN_SUGGEST_ACTIVE -eq 1 ]] && [[ -n "$POSTDISPLAY" ]]; then
        # Remove the gray coloring and append the suggestion
        local suggestion="${POSTDISPLAY#$'\e[90m'}"
        suggestion="${suggestion%$'\e[0m'}"
        LBUFFER+="$suggestion"
        POSTDISPLAY=""
        MAVEN_SUGGEST_ACTIVE=0
    fi
}

_maven_clear_suggest() {
    POSTDISPLAY=""
    MAVEN_SUGGEST_ACTIVE=0
}

# Set up ZLE widgets
zle -N maven-inline-suggest _maven_inline_suggest
zle -N maven-accept-suggest _maven_accept_suggest
zle -N maven-clear-suggest _maven_clear_suggest

# Hook into the line editor
_maven_zle_line_pre_redraw() {
    _maven_inline_suggest
}

# Common maven command patterns for quick insertion
_maven_quick_clean_install() {
    LBUFFER="mvn clean install"
    _maven_clear_suggest
}

_maven_quick_clean_package() {
    LBUFFER="mvn clean package"
    _maven_clear_suggest
}

_maven_quick_spring_boot_run() {
    LBUFFER="mvn spring-boot:run"
    _maven_clear_suggest
}

_maven_quick_skip_tests() {
    LBUFFER+=" -DskipTests"
    _maven_clear_suggest
}

zle -N maven-quick-clean-install _maven_quick_clean_install
zle -N maven-quick-clean-package _maven_quick_clean_package
zle -N maven-quick-spring-boot-run _maven_quick_spring_boot_run  
zle -N maven-quick-skip-tests _maven_quick_skip_tests

# Set up key bindings
bindkey '^[[1;5C' maven-accept-suggest  # Ctrl+Right to accept suggestion
bindkey '\t' maven-accept-suggest        # Tab to accept suggestion
bindkey '^[mc' maven-quick-clean-install # Alt+m, c for clean install
bindkey '^[mp' maven-quick-clean-package # Alt+m, p for clean package
bindkey '^[mr' maven-quick-spring-boot-run # Alt+m, r for spring boot run
bindkey '^[ms' maven-quick-skip-tests    # Alt+m, s to add -DskipTests

# Hook into zsh-syntax-highlighting if available
if (( $+functions[_zsh_highlight_call_widget] )); then
    _zsh_highlight_call_widget() {
        _maven_inline_suggest
    }
fi

# Add pre-redraw hook
autoload -U add-zle-hook-widget
add-zle-hook-widget line-pre-redraw _maven_zle_line_pre_redraw

# Enhanced completion with pom.xml awareness
_maven_complete_from_pom() {
    local word="$1"
    local pom_file="pom.xml"
    
    if [[ -f "$pom_file" ]]; then
        case "$word" in
            *:*)
                # Plugin goal completion
                local plugin="${word%:*}"
                # This could be enhanced to parse pom.xml for actual plugins
                ;;
        esac
    fi
}