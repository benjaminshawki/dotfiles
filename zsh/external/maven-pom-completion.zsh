# Maven pom.xml aware completion enhancements
# Provides context-aware completions based on pom.xml content

# Cache for parsed pom.xml data
typeset -gA _MAVEN_POM_CACHE
typeset -g _MAVEN_POM_MTIME=""

_maven_parse_pom() {
    local pom_file="${1:-pom.xml}"
    
    if [[ ! -f "$pom_file" ]]; then
        return 1
    fi
    
    # Check if we need to reparse (file modified)
    local current_mtime=$(stat -c %Y "$pom_file" 2>/dev/null || stat -f %m "$pom_file" 2>/dev/null)
    if [[ "$current_mtime" == "$_MAVEN_POM_MTIME" ]] && [[ ${#_MAVEN_POM_CACHE} -gt 0 ]]; then
        return 0
    fi
    
    _MAVEN_POM_MTIME="$current_mtime"
    _MAVEN_POM_CACHE=()
    
    # Parse profiles
    if command -v xmllint >/dev/null 2>&1; then
        local profiles=(${(f)"$(xmllint --xpath "//profile/id/text()" "$pom_file" 2>/dev/null)"})
        _MAVEN_POM_CACHE[profiles]="${profiles[*]}"
        
        # Parse plugin artifactIds for goal completion
        local plugins=(${(f)"$(xmllint --xpath "//plugin/artifactId/text()" "$pom_file" 2>/dev/null)"})
        _MAVEN_POM_CACHE[plugins]="${plugins[*]}"
        
        # Parse modules for reactor builds
        local modules=(${(f)"$(xmllint --xpath "//module/text()" "$pom_file" 2>/dev/null)"})
        _MAVEN_POM_CACHE[modules]="${modules[*]}"
    fi
}

# Enhanced completion function that uses pom.xml data
_mvn_enhanced() {
    local curcontext="$curcontext" state line
    typeset -A opt_args
    
    # Parse pom.xml if available
    _maven_parse_pom
    
    # Get cached data
    local -a profiles plugins modules
    profiles=(${=_MAVEN_POM_CACHE[profiles]})
    plugins=(${=_MAVEN_POM_CACHE[plugins]})
    modules=(${=_MAVEN_POM_CACHE[modules]})
    
    # Generate plugin-specific goals
    local -a plugin_goals
    for plugin in $plugins; do
        case "$plugin" in
            maven-compiler-plugin)
                plugin_goals+=("compiler:compile" "compiler:testCompile")
                ;;
            maven-surefire-plugin)
                plugin_goals+=("surefire:test")
                ;;
            maven-failsafe-plugin)
                plugin_goals+=("failsafe:integration-test" "failsafe:verify")
                ;;
            spring-boot-maven-plugin)
                plugin_goals+=("spring-boot:run" "spring-boot:start" "spring-boot:stop" "spring-boot:repackage")
                ;;
            maven-javadoc-plugin)
                plugin_goals+=("javadoc:javadoc" "javadoc:jar")
                ;;
            maven-source-plugin)
                plugin_goals+=("source:jar" "source:test-jar")
                ;;
            maven-release-plugin)
                plugin_goals+=("release:prepare" "release:perform" "release:clean" "release:rollback")
                ;;
            maven-assembly-plugin)
                plugin_goals+=("assembly:single" "assembly:assembly")
                ;;
            maven-dependency-plugin)
                plugin_goals+=("dependency:tree" "dependency:list" "dependency:analyze" "dependency:copy-dependencies")
                ;;
            versions-maven-plugin)
                plugin_goals+=("versions:set" "versions:commit" "versions:revert" "versions:display-dependency-updates")
                ;;
        esac
    done
    
    # Profile completion
    if [[ ${#profiles} -gt 0 ]]; then
        _arguments "-P[Activate profiles]:profile:_values -s ',' 'profiles' $profiles"
    fi
    
    # Module completion for reactor builds
    if [[ ${#modules} -gt 0 ]]; then
        _arguments "-pl[Build specified modules]:module:_values -s ',' 'modules' $modules"
    fi
    
    # Add plugin goals to completion
    if [[ ${#plugin_goals} -gt 0 ]]; then
        compadd -a plugin_goals
    fi
}

# Override the default _mvn completion with enhanced version
compdef _mvn_enhanced mvn mvnw mvnDebug

# Intelligent property completion based on context
_maven_property_complete() {
    local current="${LBUFFER##*-D}"
    local -a properties
    
    # Common properties
    properties=(
        'skipTests=true:Skip test execution'
        'maven.test.skip=true:Skip test compilation and execution'
        'maven.javadoc.skip=true:Skip javadoc generation'
        'maven.source.skip=true:Skip source jar generation'
    )
    
    # Spring Boot properties if spring-boot plugin is present
    if [[ "${_MAVEN_POM_CACHE[plugins]}" == *"spring-boot-maven-plugin"* ]]; then
        properties+=(
            'spring.profiles.active=dev:Activate Spring profile'
            'spring.profiles.active=test:Activate Spring profile'
            'spring.profiles.active=prod:Activate Spring profile'
            'spring-boot.run.profiles=dev:Spring Boot run profiles'
            'spring-boot.run.arguments=:Spring Boot run arguments'
        )
    fi
    
    # Database properties if common DB dependencies detected
    properties+=(
        'spring.datasource.url=:Database URL'
        'spring.datasource.username=:Database username'
        'spring.datasource.password=:Database password'
    )
    
    _describe -t properties 'maven properties' properties
}

# Quick snippet insertion for common maven commands
typeset -gA maven_snippets
maven_snippets=(
    "mci"    "mvn clean install"
    "mcp"    "mvn clean package"
    "mct"    "mvn clean test"
    "mcist"  "mvn clean install -DskipTests"
    "mcpst"  "mvn clean package -DskipTests"
    "mdt"    "mvn dependency:tree"
    "mdl"    "mvn dependency:list"
    "mda"    "mvn dependency:analyze"
    "msbr"   "mvn spring-boot:run"
    "msbrd"  "mvn spring-boot:run -Dspring-boot.run.profiles=dev"
    "mvdu"   "mvn versions:display-dependency-updates"
    "mvpu"   "mvn versions:display-plugin-updates"
    "mvs"    "mvn versions:set -DnewVersion="
    "mvc"    "mvn versions:commit"
    "mvr"    "mvn versions:revert"
    "mep"    "mvn help:effective-pom"
    "mes"    "mvn help:effective-settings"
    "mrp"    "mvn release:prepare"
    "mrf"    "mvn release:perform"
)

# Expand maven snippets
_maven_expand_snippet() {
    local word="${LBUFFER##* }"
    if [[ -n "${maven_snippets[$word]}" ]]; then
        LBUFFER="${LBUFFER%$word}${maven_snippets[$word]}"
        _maven_clear_suggest
    else
        # Fall back to regular expand-or-complete
        zle expand-or-complete
    fi
}

zle -N maven-expand-snippet _maven_expand_snippet

# Bind space to expand snippets
_maven_space_expand() {
    local word="${LBUFFER##* }"
    if [[ -n "${maven_snippets[$word]}" ]]; then
        LBUFFER="${LBUFFER%$word}${maven_snippets[$word]} "
        _maven_clear_suggest
    else
        LBUFFER+=" "
    fi
}

zle -N maven-space-expand _maven_space_expand

# Enable snippet expansion on space for maven commands
_maven_check_context() {
    [[ "$LBUFFER" =~ ^(mvn|mvnw|mvnDebug)[[:space:]] ]] || [[ "$LBUFFER" =~ ^m[[:alpha:]]+ ]]
}

# Wrap the space key behavior
_smart_space() {
    if _maven_check_context; then
        zle maven-space-expand
    else
        zle self-insert
    fi
}

zle -N smart-space _smart_space
bindkey ' ' smart-space