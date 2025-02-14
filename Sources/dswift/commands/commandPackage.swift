//
//  commandPackage.swift
//  dswift
//
//  Created by Tyler Anger on 2019-07-21.
//

import Foundation
import XcodeProj
import PBXProj


extension Commands {
    
    static let BAHS_AUTO_COMPLETE: String = """
    #!/bin/bash

    _dswift()
    {
        declare -a cur prev
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"

        COMPREPLY=()
        if [[ $COMP_CWORD == 1 ]]; then
            _dswift_compiler
            COMPREPLY+=( $(compgen -W "build rebuild run package test" -- $cur) )
            return
        fi
        case ${COMP_WORDS[1]} in
            (build)
                _dswift_build 2
                ;;
            (rebuild)
                _dswift_build 2
                ;;
            (run)
                _dswift_run 2
                ;;
            (package)
                _dswift_package 2
                ;;
            (test)
                _dswift_test 2
                ;;
            (*)
                _dswift_compiler
                ;;
        esac
    }
    # Generates completions for swift build
    #
    # Parameters
    # - the start position of this parser; set to 1 if unknown
    function _dswift_build
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "-Xcc -Xswiftc -Xlinker -Xcxx --configuration -c --build-path --chdir -C --package-path --enable-prefetching --disable-prefetching --disable-sandbox --version --destination --verbose -v --no-static-swift-stdlib --static-swift-stdlib --build-tests --product --target --show-bin-path" -- $cur) )
            return
        fi
        case $prev in
            (-Xcc)
                return
            ;;
            (-Xswiftc)
                return
            ;;
            (-Xlinker)
                return
            ;;
            (-Xcxx)
                return
            ;;
            (--configuration|-c)
                COMPREPLY=( $(compgen -W "debug release" -- $cur) )
                return
            ;;
            (--build-path)
                _filedir
                return
            ;;
            (--chdir|-C)
                _filedir
                return
            ;;
            (--package-path)
                _filedir
                return
            ;;
            (--enable-prefetching)
            ;;
            (--disable-prefetching)
            ;;
            (--disable-sandbox)
            ;;
            (--version)
            ;;
            (--destination)
                _filedir
                return
            ;;
            (--verbose|-v)
            ;;
            (--no-static-swift-stdlib)
            ;;
            (--static-swift-stdlib)
            ;;
            (--build-tests)
            ;;
            (--product)
                return
            ;;
            (--target)
                return
            ;;
            (--show-bin-path)
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "-Xcc -Xswiftc -Xlinker -Xcxx --configuration -c --build-path --chdir -C --package-path --enable-prefetching --disable-prefetching --disable-sandbox --version --destination --verbose -v --no-static-swift-stdlib --static-swift-stdlib --build-tests --product --target --show-bin-path" -- $cur) )
    }

    # Generates completions for swift run
    #
    # Parameters
    # - the start position of this parser; set to 1 if unknown
    function _dswift_run
    {
        if [[ $COMP_CWORD == $(($1+0)) ]]; then
                return
        fi
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "-Xcc -Xswiftc -Xlinker -Xcxx --configuration -c --build-path --chdir -C --package-path --enable-prefetching --disable-prefetching --disable-sandbox --version --destination --verbose -v --no-static-swift-stdlib --static-swift-stdlib --skip-build" -- $cur) )
            return
        fi
        case $prev in
            (-Xcc)
                return
            ;;
            (-Xswiftc)
                return
            ;;
            (-Xlinker)
                return
            ;;
            (-Xcxx)
                return
            ;;
            (--configuration|-c)
                COMPREPLY=( $(compgen -W "debug release" -- $cur) )
                return
            ;;
            (--build-path)
                _filedir
                return
            ;;
            (--chdir|-C)
                _filedir
                return
            ;;
            (--package-path)
                _filedir
                return
            ;;
            (--enable-prefetching)
            ;;
            (--disable-prefetching)
            ;;
            (--disable-sandbox)
            ;;
            (--version)
            ;;
            (--destination)
                _filedir
                return
            ;;
            (--verbose|-v)
            ;;
            (--no-static-swift-stdlib)
            ;;
            (--static-swift-stdlib)
            ;;
            (--skip-build)
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "-Xcc -Xswiftc -Xlinker -Xcxx --configuration -c --build-path --chdir -C --package-path --enable-prefetching --disable-prefetching --disable-sandbox --version --destination --verbose -v --no-static-swift-stdlib --static-swift-stdlib --skip-build" -- $cur) )
    }

    # Generates completions for swift package
    #
    # Parameters
    # - the start position of this parser; set to 1 if unknown
    function _dswift_package
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "update show-dependencies resolve fetch edit tools-version describe clean completion-tool generate-completion-script install-completion-script reset resolve-tool unedit init generate-xcodeproj dump-package -Xcc -Xswiftc -Xlinker -Xcxx --configuration -c --build-path --chdir -C --package-path --enable-prefetching --disable-prefetching --disable-sandbox --version --destination --verbose -v --no-static-swift-stdlib --static-swift-stdlib" -- $cur) )
            return
        fi
        case $prev in
            (-Xcc)
                return
            ;;
            (-Xswiftc)
                return
            ;;
            (-Xlinker)
                return
            ;;
            (-Xcxx)
                return
            ;;
            (--configuration|-c)
                COMPREPLY=( $(compgen -W "debug release" -- $cur) )
                return
            ;;
            (--build-path)
                _filedir
                return
            ;;
            (--chdir|-C)
                _filedir
                return
            ;;
            (--package-path)
                _filedir
                return
            ;;
            (--enable-prefetching)
            ;;
            (--disable-prefetching)
            ;;
            (--disable-sandbox)
            ;;
            (--version)
            ;;
            (--destination)
                _filedir
                return
            ;;
            (--verbose|-v)
            ;;
            (--no-static-swift-stdlib)
            ;;
            (--static-swift-stdlib)
            ;;
        esac
        case ${COMP_WORDS[$1]} in
            (update)
                _dswift_package_update $(($1+1))
                return
            ;;
            (show-dependencies)
                _dswift_package_show-dependencies $(($1+1))
                return
            ;;
            (resolve)
                _dswift_package_resolve $(($1+1))
                return
            ;;
            (fetch)
                _dswift_package_fetch $(($1+1))
                return
            ;;
            (edit)
                _dswift_package_edit $(($1+1))
                return
            ;;
            (tools-version)
                _dswift_package_tools-version $(($1+1))
                return
            ;;
            (describe)
                _dswift_package_describe $(($1+1))
                return
            ;;
            (clean)
                _dswift_package_clean $(($1+1))
                return
            ;;
            (generate-completion-script)
                _dswift_package_generate-completion-script $(($1+1))
                return
            ;;
            (completion-tool)
                _dswift_package_completion-tool $(($1+1))
                return
            ;;
            (install-completion-script)
                _dswift_package_generate-completion-script $(($1+1))
                return
            ;;
            (reset)
                _dswift_package_reset $(($1+1))
                return
            ;;
            (resolve-tool)
                _dswift_package_resolve-tool $(($1+1))
                return
            ;;
            (unedit)
                _dswift_package_unedit $(($1+1))
                return
            ;;
            (init)
                _dswift_package_init $(($1+1))
                return
            ;;
            (generate-xcodeproj)
                _dswift_package_generate-xcodeproj $(($1+1))
                return
            ;;
            (dump-package)
                _dswift_package_dump-package $(($1+1))
                return
            ;;
        esac
        COMPREPLY=( $(compgen -W "update show-dependencies resolve fetch edit tools-version describe clean completion-tool generate-completion-script install-completion-script reset resolve-tool unedit init generate-xcodeproj dump-package -Xcc -Xswiftc -Xlinker -Xcxx --configuration -c --build-path --chdir -C --package-path --enable-prefetching --disable-prefetching --disable-sandbox --version --destination --verbose -v --no-static-swift-stdlib --static-swift-stdlib" -- $cur) )
    }

    function _dswift_package_update
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "" -- $cur) )
            return
        fi
        case $prev in
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "" -- $cur) )
    }

    function _dswift_package_show-dependencies
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--format" -- $cur) )
            return
        fi
        case $prev in
            (--format)
                COMPREPLY=( $(compgen -W "text dot json" -- $cur) )
                return
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--format" -- $cur) )
    }

    function _dswift_package_resolve
    {
        if [[ $COMP_CWORD == $(($1+0)) ]]; then
                return
        fi
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--version --branch --revision" -- $cur) )
            return
        fi
        case $prev in
            (--version)
                return
            ;;
            (--branch)
                return
            ;;
            (--revision)
                return
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--version --branch --revision" -- $cur) )
    }

    function _dswift_package_fetch
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "" -- $cur) )
            return
        fi
        case $prev in
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "" -- $cur) )
    }

    function _dswift_package_edit
    {
        if [[ $COMP_CWORD == $(($1+0)) ]]; then
                return
        fi
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--revision --branch --path" -- $cur) )
            return
        fi
        case $prev in
            (--revision)
                return
            ;;
            (--branch)
                return
            ;;
            (--path)
                _filedir
                return
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--revision --branch --path" -- $cur) )
    }

    function _dswift_package_tools-version
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--set --set-current" -- $cur) )
            return
        fi
        case $prev in
            (--set)
                return
            ;;
            (--set-current)
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--set --set-current" -- $cur) )
    }

    function _dswift_package_describe
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--type" -- $cur) )
            return
        fi
        case $prev in
            (--type)
                COMPREPLY=( $(compgen -W "text json" -- $cur) )
                return
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--type" -- $cur) )
    }

    function _dswift_package_clean
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "" -- $cur) )
            return
        fi
        case $prev in
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "" -- $cur) )
    }
    
    function _dswift_package_generate-completion-script
    {
        if [[ $COMP_CWORD == $(($1+0)) ]]; then
                COMPREPLY=( $(compgen -W "bash zsh" -- $cur) )
                return
        fi
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "" -- $cur) )
            return
        fi
        case $prev in
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "" -- $cur) )
    }

    function _dswift_package_completion-tool
    {
        if [[ $COMP_CWORD == $(($1+0)) ]]; then
                COMPREPLY=( $(compgen -W "generate-bash-script generate-zsh-script" -- $cur) )
                return
        fi
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "" -- $cur) )
            return
        fi
        case $prev in
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "" -- $cur) )
    }

    function _dswift_package_reset
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "" -- $cur) )
            return
        fi
        case $prev in
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "" -- $cur) )
    }

    function _dswift_package_resolve-tool
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--type" -- $cur) )
            return
        fi
        case $prev in
            (--type)
                COMPREPLY=( $(compgen -W "text json" -- $cur) )
                return
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--type" -- $cur) )
    }

    function _dswift_package_unedit
    {
        if [[ $COMP_CWORD == $(($1+0)) ]]; then
                return
        fi
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--force" -- $cur) )
            return
        fi
        case $prev in
            (--force)
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--force" -- $cur) )
    }

    function _dswift_package_init
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--noDSwift --type" -- $cur) )
            return
        fi
        case $prev in
            (--type)
                COMPREPLY=( $(compgen -W "empty library executable system-module manifest" -- $cur) )
                return
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--noDSwift --type" -- $cur) )
    }

    function _dswift_package_generate-xcodeproj
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "--xcconfig-overrides --enable-code-coverage --output" -- $cur) )
            return
        fi
        case $prev in
            (--xcconfig-overrides)
                _filedir
                return
            ;;
            (--enable-code-coverage)
            ;;
            (--output)
                _filedir
                return
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "--xcconfig-overrides --enable-code-coverage --output" -- $cur) )
    }

    function _dswift_package_dump-package
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "" -- $cur) )
            return
        fi
        case $prev in
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "" -- $cur) )
    }

    # Generates completions for swift test
    #
    # Parameters
    # - the start position of this parser; set to 1 if unknown
    function _dswift_test
    {
        if [[ $COMP_CWORD == $1 ]]; then
            COMPREPLY=( $(compgen -W "-Xcc -Xswiftc -Xlinker -Xcxx --configuration -c --build-path --chdir -C --package-path --enable-prefetching --disable-prefetching --disable-sandbox --version --destination --verbose -v --no-static-swift-stdlib --static-swift-stdlib --skip-build --list-tests -l --parallel --specifier -s --filter" -- $cur) )
            return
        fi
        case $prev in
            (-Xcc)
                return
            ;;
            (-Xswiftc)
                return
            ;;
            (-Xlinker)
                return
            ;;
            (-Xcxx)
                return
            ;;
            (--configuration|-c)
                COMPREPLY=( $(compgen -W "debug release" -- $cur) )
                return
            ;;
            (--build-path)
                _filedir
                return
            ;;
            (--chdir|-C)
                _filedir
                return
            ;;
            (--package-path)
                _filedir
                return
            ;;
            (--enable-prefetching)
            ;;
            (--disable-prefetching)
            ;;
            (--disable-sandbox)
            ;;
            (--version)
            ;;
            (--destination)
                _filedir
                return
            ;;
            (--verbose|-v)
            ;;
            (--no-static-swift-stdlib)
            ;;
            (--static-swift-stdlib)
            ;;
            (--skip-build)
            ;;
            (--list-tests|-l)
            ;;
            (--parallel)
            ;;
            (--specifier|-s)
                return
            ;;
            (--filter)
                return
            ;;
        esac
        case ${COMP_WORDS[$1]} in
        esac
        COMPREPLY=( $(compgen -W "-Xcc -Xswiftc -Xlinker -Xcxx --configuration -c --build-path --chdir -C --package-path --enable-prefetching --disable-prefetching --disable-sandbox --version --destination --verbose -v --no-static-swift-stdlib --static-swift-stdlib --skip-build --list-tests -l --parallel --specifier -s --filter" -- $cur) )
    }

    _dswift_compiler()
    {
        if [[ `type -t _dswift_complete`"" == 'function' ]]; then
            _dswift_complete
        fi
    }

    complete -F _dswift dswift
    """
    static let ZSH_AUTO_COMPLETE: String = """
    #compdef dswift
    local context state state_descr line
    typeset -A opt_args

    _dswift() {
        _arguments -C \
            '(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
            '(-): :->command' \
            '(-)*:: :->arg' && return

        case $state in
            (command)
                local tools
                tools=(
                    'build:build sources into binary products'
                    'rebuild:rebuild dswift files then build sources into binary products'
                    'run:build and run an executable product'
                    'package:perform operations on Swift packages'
                    'test:build and run tests'
                )
                _alternative \
                    'tools:common:{_describe "tool" tools }' \
                    'compiler: :_dswift_compiler' && _ret=0
                ;;
            (arg)
                case ${words[1]} in
                    (build)
                        _dswift_build
                        ;;
                    (rebuild)
                        _dswift_build
                        ;;
                    (run)
                        _dswift_run
                        ;;
                    (package)
                        _dswift_package
                        ;;
                    (test)
                        _dswift_test
                        ;;
                    (*)
                        _dswift_compiler
                        ;;
                esac
                ;;
        esac
    }

    # Generates completions for swift build
    #
    # In the final compdef file, set the following file header:
    #
    #     #compdef _dswift_build
    #     local context state state_descr line
    #     typeset -A opt_args
    _dswift_build() {
        arguments=(
            "-Xcc[Pass flag through to all C compiler invocations]:Pass flag through to all C compiler invocations: "
            "-Xswiftc[Pass flag through to all Swift compiler invocations]:Pass flag through to all Swift compiler invocations: "
            "-Xlinker[Pass flag through to all linker invocations]:Pass flag through to all linker invocations: "
            "-Xcxx[Pass flag through to all C++ compiler invocations]:Pass flag through to all C++ compiler invocations: "
            "(--configuration -c)"{--configuration,-c}"[Build with configuration (debug|release) ]: :{_values '' 'debug[build with DEBUG configuration]' 'release[build with RELEASE configuration]'}"
            "--build-path[Specify build/cache directory ]:Specify build/cache directory :_files"
            "(--chdir -C)"{--chdir,-C}"[]: :_files"
            "--package-path[Change working directory before any other operation]:Change working directory before any other operation:_files"
            "--enable-prefetching[]"
            "--disable-prefetching[]"
            "--disable-sandbox[Disable using the sandbox when executing subprocesses]"
            "--version[]"
            "--destination[]: :_files"
            "(--verbose -v)"{--verbose,-v}"[Increase verbosity of informational output]"
            "--no-static-swift-stdlib[Do not link Swift stdlib statically]"
            "--static-swift-stdlib[Link Swift stdlib statically]"
            "--build-tests[Build both source and test targets]"
            "--product[Build the specified product]:Build the specified product: "
            "--target[Build the specified target]:Build the specified target: "
            "--show-bin-path[Print the binary output path]"
        )
        _arguments $arguments && return
    }

    # Generates completions for swift run
    #
    # In the final compdef file, set the following file header:
    #
    #     #compdef _dswift_run
    #     local context state state_descr line
    #     typeset -A opt_args
    _dswift_run() {
        arguments=(
            ":The executable to run: "
            "-Xcc[Pass flag through to all C compiler invocations]:Pass flag through to all C compiler invocations: "
            "-Xswiftc[Pass flag through to all Swift compiler invocations]:Pass flag through to all Swift compiler invocations: "
            "-Xlinker[Pass flag through to all linker invocations]:Pass flag through to all linker invocations: "
            "-Xcxx[Pass flag through to all C++ compiler invocations]:Pass flag through to all C++ compiler invocations: "
            "(--configuration -c)"{--configuration,-c}"[Build with configuration (debug|release) ]: :{_values '' 'debug[build with DEBUG configuration]' 'release[build with RELEASE configuration]'}"
            "--build-path[Specify build/cache directory ]:Specify build/cache directory :_files"
            "(--chdir -C)"{--chdir,-C}"[]: :_files"
            "--package-path[Change working directory before any other operation]:Change working directory before any other operation:_files"
            "--enable-prefetching[]"
            "--disable-prefetching[]"
            "--disable-sandbox[Disable using the sandbox when executing subprocesses]"
            "--version[]"
            "--destination[]: :_files"
            "(--verbose -v)"{--verbose,-v}"[Increase verbosity of informational output]"
            "--no-static-swift-stdlib[Do not link Swift stdlib statically]"
            "--static-swift-stdlib[Link Swift stdlib statically]"
            "--skip-build[Skip building the executable product]"
        )
        _arguments $arguments && return
    }

    # Generates completions for swift package
    #
    # In the final compdef file, set the following file header:
    #
    #     #compdef _dswift_package
    #     local context state state_descr line
    #     typeset -A opt_args
    _dswift_package() {
        arguments=(
            "-Xcc[Pass flag through to all C compiler invocations]:Pass flag through to all C compiler invocations: "
            "-Xswiftc[Pass flag through to all Swift compiler invocations]:Pass flag through to all Swift compiler invocations: "
            "-Xlinker[Pass flag through to all linker invocations]:Pass flag through to all linker invocations: "
            "-Xcxx[Pass flag through to all C++ compiler invocations]:Pass flag through to all C++ compiler invocations: "
            "(--configuration -c)"{--configuration,-c}"[Build with configuration (debug|release) ]: :{_values '' 'debug[build with DEBUG configuration]' 'release[build with RELEASE configuration]'}"
            "--build-path[Specify build/cache directory ]:Specify build/cache directory :_files"
            "(--chdir -C)"{--chdir,-C}"[]: :_files"
            "--package-path[Change working directory before any other operation]:Change working directory before any other operation:_files"
            "--enable-prefetching[]"
            "--disable-prefetching[]"
            "--disable-sandbox[Disable using the sandbox when executing subprocesses]"
            "--version[]"
            "--destination[]: :_files"
            "(--verbose -v)"{--verbose,-v}"[Increase verbosity of informational output]"
            "--no-static-swift-stdlib[Do not link Swift stdlib statically]"
            "--static-swift-stdlib[Link Swift stdlib statically]"
            '(-): :->command'
            '(-)*:: :->arg'
        )
        _arguments $arguments && return
        case $state in
            (command)
                local modes
                modes=(
                    'update:Update package dependencies'
                    'show-dependencies:Print the resolved dependency graph'
                    'resolve:Resolve package dependencies'
                    'fetch:'
                    'edit:Put a package in editable mode'
                    'tools-version:Manipulate tools version of the current package'
                    'describe:Describe the current package'
                    'clean:Delete build artifacts'
                    'generate-completion-script:Generate completion script (Bash or ZSH)'
                    'completion-tool:Generate completion script (generate-bash-script or generate-zsh-script)'
                    'install-completion-script:Install completion script (Bash or ZSH)'
                    'reset:Reset the complete cache/build directory'
                    'resolve-tool:'
                    'unedit:Remove a package from editable mode'
                    'init:Initialize a new package'
                    'generate-xcodeproj:Generates an Xcode project'
                    'dump-package:Print parsed Package.swift as JSON'
                )
                _describe "mode" modes
                ;;
            (arg)
                case ${words[1]} in
                    (update)
                        _dswift_package_update
                        ;;
                    (show-dependencies)
                        _dswift_package_show-dependencies
                        ;;
                    (resolve)
                        _dswift_package_resolve
                        ;;
                    (fetch)
                        _dswift_package_fetch
                        ;;
                    (edit)
                        _dswift_package_edit
                        ;;
                    (tools-version)
                        _dswift_package_tools-version
                        ;;
                    (describe)
                        _dswift_package_describe
                        ;;
                    (clean)
                        _dswift_package_clean
                        ;;
                    (generate-completion-script)
                        _dswift_package_generate-completion-script
                        ;;
                    (completion-tool)
                        _dswift_package_completion-tool
                        ;;
                    (install-completion-script)
                        _dswift_package_generate-completion-script
                        ;;
                    (reset)
                        _dswift_package_reset
                        ;;
                    (resolve-tool)
                        _dswift_package_resolve-tool
                        ;;
                    (unedit)
                        _dswift_package_unedit
                        ;;
                    (init)
                        _dswift_package_init
                        ;;
                    (generate-xcodeproj)
                        _dswift_package_generate-xcodeproj
                        ;;
                    (dump-package)
                        _dswift_package_dump-package
                        ;;
                esac
                ;;
        esac
    }

    _dswift_package_update() {
        arguments=(
        )
        _arguments $arguments && return
    }

    _dswift_package_show-dependencies() {
        arguments=(
            "--format[text|dot|json]: :{_values '' 'text[list dependencies using text format]' 'dot[list dependencies using dot format]' 'json[list dependencies using JSON format]'}"
        )
        _arguments $arguments && return
    }

    _dswift_package_resolve() {
        arguments=(
            ":The name of the package to resolve: "
            "--version[The version to resolve at]:The version to resolve at: "
            "--branch[The branch to resolve at]:The branch to resolve at: "
            "--revision[The revision to resolve at]:The revision to resolve at: "
        )
        _arguments $arguments && return
    }

    _dswift_package_fetch() {
        arguments=(
        )
        _arguments $arguments && return
    }

    _dswift_package_edit() {
        arguments=(
            ":The name of the package to edit: "
            "--revision[The revision to edit]:The revision to edit: "
            "--branch[The branch to create]:The branch to create: "
            "--path[Create or use the checkout at this path]:Create or use the checkout at this path:_files"
        )
        _arguments $arguments && return
    }

    _dswift_package_tools-version() {
        arguments=(
            "--set[Set tools version of package to the given value]:Set tools version of package to the given value: "
            "--set-current[Set tools version of package to the current tools version in use]"
        )
        _arguments $arguments && return
    }

    _dswift_package_describe() {
        arguments=(
            "--type[json|text]: :{_values '' 'text[describe using text format]' 'json[describe using JSON format]'}"
        )
        _arguments $arguments && return
    }

    _dswift_package_clean() {
        arguments=(
        )
        _arguments $arguments && return
    }

    _dswift_package_generate-completion-script() {
        arguments=(
            ": :{_values '' 'bash[generate completion script for Bourne-again shell]' 'zsh[generate completion script for Z shell]'}"
        )
        _arguments $arguments && return
    }

    _dswift_package_completion-tool() {
        arguments=(
            ": :{_values '' 'generate-bash-script[generate completion script for Bourne-again shell]' 'generate-zsh-script[generate completion script for Z shell]'}"
        )
        _arguments $arguments && return
    }

    _dswift_package_reset() {
        arguments=(
        )
        _arguments $arguments && return
    }

    _dswift_package_resolve-tool() {
        arguments=(
            "--type[text|json]: :{_values '' 'text[resolve using text format]' 'json[resolve using JSON format]'}"
        )
        _arguments $arguments && return
    }

    _dswift_package_unedit() {
        arguments=(
            ":The name of the package to unedit: "
            "--force[Unedit the package even if it has uncommited and unpushed changes.]"
        )
        _arguments $arguments && return
    }

    _dswift_package_init() {
        arguments=(
            "--noDSwift[Do not do any dynamic swift specific generating]"
            "--type[empty|library|executable|system-module|manifest]: :{_values '' 'empty[generates an empty project]' 'library[generates project for a dynamic library]' 'executable[generates a project for a cli executable]' 'system-module[generates a project for a system module]' 'manifest[generates a project with only the maifiest file]'}"
        )
        _arguments $arguments && return
    }

    _dswift_package_generate-xcodeproj() {
        arguments=(
            "--xcconfig-overrides[Path to xcconfig file]:Path to xcconfig file:_files"
            "--enable-code-coverage[Enable code coverage in the generated project]"
            "--output[Path where the Xcode project should be generated]:Path where the Xcode project should be generated:_files"
        )
        _arguments $arguments && return
    }

    _dswift_package_dump-package() {
        arguments=(
        )
        _arguments $arguments && return
    }

    # Generates completions for swift test
    #
    # In the final compdef file, set the following file header:
    #
    #     #compdef _dswift_test
    #     local context state state_descr line
    #     typeset -A opt_args
    _dswift_test() {
        arguments=(
            "-Xcc[Pass flag through to all C compiler invocations]:Pass flag through to all C compiler invocations: "
            "-Xswiftc[Pass flag through to all Swift compiler invocations]:Pass flag through to all Swift compiler invocations: "
            "-Xlinker[Pass flag through to all linker invocations]:Pass flag through to all linker invocations: "
            "-Xcxx[Pass flag through to all C++ compiler invocations]:Pass flag through to all C++ compiler invocations: "
            "(--configuration -c)"{--configuration,-c}"[Build with configuration (debug|release) ]: :{_values '' 'debug[build with DEBUG configuration]' 'release[build with RELEASE configuration]'}"
            "--build-path[Specify build/cache directory ]:Specify build/cache directory :_files"
            "(--chdir -C)"{--chdir,-C}"[]: :_files"
            "--package-path[Change working directory before any other operation]:Change working directory before any other operation:_files"
            "--enable-prefetching[]"
            "--disable-prefetching[]"
            "--disable-sandbox[Disable using the sandbox when executing subprocesses]"
            "--version[]"
            "--destination[]: :_files"
            "(--verbose -v)"{--verbose,-v}"[Increase verbosity of informational output]"
            "--no-static-swift-stdlib[Do not link Swift stdlib statically]"
            "--static-swift-stdlib[Link Swift stdlib statically]"
            "--skip-build[Skip building the test target]"
            "(--list-tests -l)"{--list-tests,-l}"[Lists test methods in specifier format]"
            "--parallel[Run the tests in parallel.]"
            "(--specifier -s)"{--specifier,-s}"[]: : "
            "--filter[Run test cases matching regular expression, Format: <test-target>.<test-case> or <test-target>.<test-case>/<test>]:Run test cases matching regular expression, Format: <test-target>.<test-case> or <test-target>.<test-case>/<test>: "
        )
        _arguments $arguments && return
    }

    _dswift_compiler() {
    }

    _dswift
    """
    /// Post execution method for swift package
    static func commandPackage(_ args: [String]) throws -> Int32 {
        
        let arguments = args
        //arguments.removeFirst() //First parameter is the package param
        //guard let cmd = arguments.last?.lowercased() else { return 0 }
        let packageCommand = (arguments.count >= 2 ? arguments[1] : "").lowercased()
        if arguments.contains("--help") {
            return try commandPackageHelp(args)
        } else if packageCommand == "clean" {
            return try commandPackageClean(arguments, Commands.commandSwift(args))
        } else if packageCommand == "reset" {
            return try commandPackageReset(arguments, Commands.commandSwift(args))
        } else if packageCommand == "update" {
            return try commandPackageUpdate(arguments, Commands.commandSwift(args))
        } else if packageCommand == "generate-xcodeproj" {
            return try commandPackageGenXcodeProj(arguments, Commands.commandSwift(args))
        } else if packageCommand == "generate-completion-script" {
            return try commandPackageGenAutoScript(arguments)
        } else if packageCommand == "install-completion-script" {
            return try commandPackageInstallAutoScript(arguments)
        } else if packageCommand == "init" {
            return try commandPackageInit(arguments)
        } else {
            return Commands.commandSwift(args)
        }
    }
    
    /// Clean any swift files build from dswift
    private static func cleanDSwiftBuilds() throws {
        verbosePrint("Loading package details")
        let packageDetails = try PackageDescription(swiftPath: settings.swiftPath,
                                                    packagePath: currentProjectPath,
                                                    loadDependencies: false)
        verbosePrint("Package details loaded")
        
        for t in packageDetails.targets {
            
            verbosePrint("Looking at target: \(t.name)")
            let targetPath = URL(fileURLWithPath: t.path).resolvingSymlinksInPath()
            
            try generator.clean(folder: targetPath)
            //try cleanFolder(fileExtensions: GroupGenerator.supportedExtensions, folder: targetPath)
            
        }
    }
    
    private static func resetDSwiftBuilds() throws {
        // get the current project folder
        let workingDir = currentProjectPath
        let workingURL = URL(fileURLWithPath: workingDir).resolvingSymlinksInPath()
        let urls: [URL] = [
                            workingURL.appendingPathComponent("Sources"),
                            workingURL.appendingPathComponent("Tests"),
                           ]
        for url in urls {
            if FileManager.default.fileExists(atPath: url.path) {
                verbosePrint("Looking at folder: \(url.path)")
                try generator.clean(folder: url)
            }
        }
        
    }
    
    /// swift package clean catcher
    private static func commandPackageClean(_ args: [String], _ retCode: Int32) throws -> Int32 {
        try cleanDSwiftBuilds()
        return retCode
    }
    
    /// swift package update catcher
    private static func commandPackageUpdate(_ args: [String], _ retCode: Int32) throws -> Int32 {
        guard retCode == 0 && settings.regenerateXcodeProject else { return retCode }
        
        return try processCommand(["package", "generate-xcodeproj"])
    }
    
    /// swift package reset catcher
    private static func commandPackageReset(_ args: [String], _ retCode: Int32) throws -> Int32 {
        try resetDSwiftBuilds()
        return retCode
    }
    
    /// swift package generate-xcodeproj catcher
    private static func commandPackageGenAutoScript(_ args: [String]) throws -> Int32 {
        if args.last == "bash" || args.last == "generate-bash-script" {
            print(BAHS_AUTO_COMPLETE)
            return 0
        } else if args.last == "zsh" || args.last == "generate-zsh-script" {
            print(ZSH_AUTO_COMPLETE)
            return 0
        } else if args.last == "--help" {
            let msg: String = """
            OVERVIEW: Generate completion script (Bash or ZSH)

            COMMANDS:
              flavor   Shell flavor (bash or zsh)
            """
            print(msg)
            return 0
        } else {
            errPrint("error: unknown value '\(args.last!)' for argument flavor; use --help to print usage")
            return 1
        }
    }
    
    
    /// swift package generate-xcodeproj catcher
    private static func commandPackageInstallAutoScript(_ args: [String]) throws -> Int32 {
        
        if args.last == "bash" || args.last == "generate-bash-script"  {
            var bashProfile: StringFile
            do { bashProfile = try StringFile("~/.bash_profile") }
            catch {
                errPrint("Unable to load ~/.bash_profile")
                return 1
            }
            guard !bashProfile.contains("which \(dswiftAppName)") else {
                print("Autocomplete script was previously installed")
                return 0
            }
            
            bashProfile += """
            
            # Source Dynamic Swift completion
            if [ -n "`which \(dswiftAppName)`" ]; then
            eval "`\(dswiftAppName) package generate-completion-script bash`"
            fi
            """
            
            do { try bashProfile.save() }
            catch {
                errPrint("Unable to save ~/.bash_profile")
                return 1
            }
            
            print("Autocomplete script installed.  Please run source ~/.bash_profile")
            
            return 0
        } else if args.last == "zsh" || args.last == "generate-zsh-script" {
            if let omzshPath = ProcessInfo.processInfo.environment["ZSH"] {
                var autocompletePath = omzshPath
                if !autocompletePath.hasSuffix("/") { autocompletePath += "/" }
                autocompletePath += "completions/"
                let autoScriptPath = autocompletePath + "_" + dswiftAppName
                
                if FileManager.default.fileExists(atPath: autoScriptPath) {
                    print("Autocomplete script was previously installed in Oh-My-Zsh.  Removing old copy")
                    do {
                        try FileManager.default.removeItem(atPath: autoScriptPath)
                    } catch {
                        errPrint("Unable to delete \(autoScriptPath) script")
                        return 1
                    }
                }
                
                do { try ZSH_AUTO_COMPLETE.write(toFile: autoScriptPath, atomically: true, encoding: .utf8) }
                catch {
                    errPrint("Unable to save \(autoScriptPath)")
                    return 1
                }
                
                print("Autocomplete script installed into Oh-My-Zsh.  Please start a new session")
                
                return 0
                
            } else {
            
                let zshFolderPath: String = NSString(string: "~/.zsh").expandingTildeInPath
                
                if !FileManager.default.fileExists(atPath: zshFolderPath) {
                    do {
                        try FileManager.default.createDirectory(atPath: zshFolderPath, withIntermediateDirectories: false, attributes: nil)
                    } catch {
                        errPrint("Unable to create ~/.zsh folder")
                        return 1
                    }
                }
                
                let zshProfilePath: String = NSString(string: "~/.zsh/_\(dswiftAppName)").expandingTildeInPath
                if FileManager.default.fileExists(atPath: zshProfilePath) {
                    print("Autocomplete script was previously installed.  Removing old copy")
                    do {
                        try FileManager.default.removeItem(atPath: zshProfilePath)
                    } catch {
                        errPrint("Unable to delete ~/.zsh/_\(dswiftAppName) script")
                        return 1
                    }
                }
                
                do { try ZSH_AUTO_COMPLETE.write(toFile: zshProfilePath, atomically: true, encoding: .utf8) }
                catch {
                    errPrint("Unable to save ~/.zsh/_\(dswiftAppName)")
                    return 1
                }
                
                
                var zshProfile: StringFile
                do { zshProfile = try StringFile("~/.zshrc") }
                catch {
                    errPrint("Unable to load ~/.zshrc")
                    return 1
                }
                
                guard !zshProfile.contains("fpath=(~/.zsh $fpath)") else {
                    print("Autocomplete script installed.  Please run compinit")
                    return 0
                }
                
                zshProfile += "fpath=(~/.zsh $fpath)\n"
                
                do { try zshProfile.save() }
                catch {
                    errPrint("Unable to save ~/.zshrc")
                    return 1
                }
                
               print("Autocomplete script installed.  Please run compinit")
                
                return 0
            }
         } else if args.last == "--help" {
            let msg: String = """
            OVERVIEW: Install completion script (Bash or ZSH)

            COMMANDS:
              flavor   Shell flavor (bash or zsh)
            """
            print(msg)
            return 0
        } else {
            if args.last! != "install-completion-script" {
                errPrint("error: unknown value '\(args.last!)' for argument flavor; use --help to print usage")
            } else {
                errPrint("error: missing flavor; use --help to print usage")
            }
            return 1
        }
    }
    
    /// swift package generate-xcodeproj catcher
    private static func commandPackageHelp(_ args: [String]) throws -> Int32 {
        
        let task = newProcess()
        
        task.executable = URL(fileURLWithPath: settings.swiftPath)
        task.arguments = args
        
        let pipe = Pipe()
        defer {
            pipe.fileHandleForReading.closeFile()
            pipe.fileHandleForWriting.closeFile()
        }
        //#if os(macOS)
        //task.standardInput = FileHandle.nullDevice
        //#endif
        task.standardOutput = pipe
        task.standardError = pipe
        
        try! task.execute()
        task.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        var str = String(data: data, encoding: .utf8)!
        
        str = str.replacingOccurrences(of: "USAGE: swift", with: "USAGE: \(dswiftAppName)")
        guard task.terminationStatus == 0 else {
            errPrint(str)
            return task.terminationStatus
        }
        
        str = str.replacingOccurrences(of: "  generate-completion-script\n                          Generate completion script (Bash or ZSH)",
                                       with: "  generate-completion-script\n                          Generate completion script (Bash or ZSH)\n  install-completion-script\n                          Install completion script (Bash or ZSH)")
        
        print(str)
        
        return task.terminationStatus
    }
    
    /// swift package init catcher
    private static func commandPackageInit(_ args: [String]) throws -> Int32 {
        
        var args = args
        let noDSwift = args.contains(where: { $0.lowercased() == "--nodswift" })
        if noDSwift { args.removeAll(where: { $0.lowercased() == "--nodswift" }) }
        var retCode = Commands.commandSwift(args)
        guard retCode == 0 else { return retCode }
        guard (args.firstIndex(of: "--help") == nil) else { return retCode }
        
        let packageType: String = {
            guard let typeParamIndex = args.firstIndex(where: { return ($0.lowercased() == "--type" ) }) else { return "" }
            guard typeParamIndex < args.count - 1 else { return "" }
            return args[typeParamIndex + 1]
        }()
        
        if let toolVer = settings.defaultPackageInitToolsVersion {
            // Set package tool-version
            _ = Commands.commandSwift(["package", "tools-version", "--set", toolVer])
        }
        
        try settings.readme.write(to: currentProjectURL.appendingPathComponent("README.md"),
                                  for: packageType.lowercased(),
                                  withName: currentProjectURL.lastPathComponent,
                                  includeDSwiftMessage: !noDSwift)
        
        /// Setup license file
        try settings.license.write(to: currentProjectURL.appendingPathComponent("LICENSE.md"))
        
        let gitIgnoreURL: URL = currentProjectURL.appendingPathComponent(".gitignore")
        
        var workingGitIgnoreFile = GitIgnoreFile.default
        if let gitIgnoreAdditions = settings.gitIgnoreAdditions {
            // Add Config git ignore additions
            workingGitIgnoreFile += gitIgnoreAdditions
        }
        
        if FileManager.default.fileExists(atPath: gitIgnoreURL.path) {
            do {
                let currentGitIgnore = try GitIgnoreFile(atPath: gitIgnoreURL.path)
                // Add existing gitignore settings
                workingGitIgnoreFile += currentGitIgnore
                
                /*var file = try StringFile(gitIgnoreURL.path)
                if !file.contains("Package.resolved") {
                    if !file.hasSuffix("\n") { file += "\n" }
                    file += "Package.resolved"
                    
                    try file.save()
                }*/
            } catch { }
        }
        
        do {
            verbosePrint("Updating .gitignore")
            try workingGitIgnoreFile.save(to: gitIgnoreURL.path)
        } catch {
            errPrint("Failed to update .gitignore")
            errPrint(error)
        }
        
        let genXcodeProj: Bool = settings.generateXcodeProjectOnInit.canGenerated(forName: args.last!.lowercased())
        
        if genXcodeProj {
            verbosePrint("Generating Xcode Project")
            retCode = try processCommand(["package", "generate-xcodeproj"])
        }
        
        
        return retCode
    }
    
    /// swift package generate-xcodeproj catcher
    private static func commandPackageGenXcodeProj(_ args: [String], _ retCode: Int32) throws -> Int32 {
        guard retCode == 0 else { return retCode }
        guard (args.firstIndex(of: "--help") == nil) else { return retCode }
        
        var returnCode: Int32 = 0
        verbosePrint("Loading package details")
        let packageDetails = try PackageDescription(swiftPath: settings.swiftPath,
                                                    packagePath: currentProjectPath,
                                                    loadDependencies: false)
        verbosePrint("Package details loaded")
        
        let packageURL: URL = currentProjectURL.resolvingSymlinksInPath()
        //let packageName: String = packageURL.lastPathComponent
        
        let xCodeProjectURL = packageURL.appendingPathComponent("\(packageDetails.name).xcodeproj")
        
        guard FileManager.default.fileExists(atPath: xCodeProjectURL.path) else {
            errPrint("Project not found. \(xCodeProjectURL.path)")
            return 1
        }
        verbosePrint("Loading Xcode project")
        let xcodeProject = try XcodeProject(fromURL: xCodeProjectURL)
        verbosePrint("Loaded Xcode project")
        
        // Only add build rule if we have supported files
        if (try settings.whenToAddBuildRules.canAddBuildRules(packageURL)) {
            for tD in packageDetails.targets {
                //guard tD.type.lowercased() != "test" else { continue }
                let relativePath = tD.path.replacingOccurrences(of: currentProjectPath, with: "")
                if let t = xcodeProject.targets.first(where: { $0.name == tD.name}),
                    let nT = t as? XcodeNativeTarget,
                    let targetGroup = xcodeProject.resources.group(atPath: relativePath)  {
                    //let targetGroup = xcodeProject.resources.group(atPath: "Sources/\(tD.name)")!
                    let rCode = try addDSwiftFilesToTarget(in: XcodeFileSystemURLResource(directory: tD.path),
                                               inGroup: targetGroup,
                                               havingTarget: nT,
                                               usingProvider: xcodeProject.fsProvider)
                    if rCode != 0 {
                        returnCode = rCode
                    }
                    
                   
                    let supportedFilePatterns: String =  generator.supportedExtensions.map({ return "*.\($0)"}).joined(separator: " ")
                    let rule = try nT.createBuildRule(name: "Dynamic Swift",
                                                            compilerSpec: "com.apple.compilers.proxy.script",
                                                            fileType: XcodeFileType.Pattern.proxy,
                                                            editable: true,
                                                            filePatterns: supportedFilePatterns,
                                                            outputFiles: ["$(INPUT_FILE_DIR)/$(INPUT_FILE_BASE).swift"],
                                                            outputFilesCompilerFlags: nil,
                                                            script: "",
                                                            atLocation: .end)
                    rule.script = """
                    if ! [ -x "$(command -v \(dswiftAppName))" ]; then
                        echo "Error: \(dswiftAppName) is not installed.  Please visit \(dSwiftURL) to download and install." >&2
                        exit 1
                    fi
                    \(dswiftAppName) xcodebuild ${INPUT_FILE_PATH}
                    """
                   
                }
            }
        }
 
        if settings.includeSwiftLintInXcodeProject == .always ||
            (settings.includeSwiftLintInXcodeProject == .whenAvailable && which("swiftlint") != nil) {
            for tD in packageDetails.targets {
                //guard tD.type.lowercased() != "test" else { continue }
                if let t = xcodeProject.targets.first(where: { $0.name == tD.name}),
                    let nT = t as? XcodeNativeTarget  {
                    
                    let rule = try nT.createShellScriptBuildPhase(name: "SwiftLint",
                                                                  atLocation: .end)
                    rule.shellScript = """
                    # Type a script or drag a script file from your workspace to insert its path.
                    if which swiftlint >/dev/null; then
                      swiftlint
                    else
                      echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
                    fi
                    """
                }
            }
        }
 
        if settings.xcodeResourceSorting == .sorted {
            xcodeProject.resources.sort()
        }
        
        var indexAfterLastPackagFile: Int = 1
        
        
        var children = try xcodeProject.fsProvider.contentsOfDirectory(at: xcodeProject.projectFolder)
        children.sort(by: { return $0.path < $1.path})
        for child in children {
            let fileName = child.lastPathComponent
            if fileName.hasPrefix("Package@swift-") && fileName.hasSuffix(".swift") {
                var packageVersion: String = fileName
                packageVersion.removeFirst("Package@swift-".count)
                packageVersion.removeLast(".swift".count)
                if let _ = Double(packageVersion) {
                    if xcodeProject.resources.file(atPath: child.lastPathComponent) == nil {
                        verbosePrint("Adding \(fileName) to project file")
                        try xcodeProject.resources.addExisting(child,
                                                               atLocation: .index(indexAfterLastPackagFile),
                                                               savePBXFile: false)
                        indexAfterLastPackagFile += 1
                    }
                }
            }
        }
        
        // Add additional files
        let additionalFiles: [String] = ["LICENSE.md", "README.md", "Tests/LinuxMain.swift"]
        for file in additionalFiles {
            let filePath = xcodeProject.projectFolder.appendingFileComponent(file)
            if try xcodeProject.fsProvider.itemExists(at: filePath) {
                var group: XcodeGroup = xcodeProject.resources
                var usingRootGroup: Bool = true
                if let idx = file.lastIndex(of: "/") { // If we find that the file is in a sub folder we must find the sub group
                    let groupPath = String(file[..<idx])
                    guard let grp = xcodeProject.resources.group(atPath: groupPath) else {
                        errPrint("Unable to find group '\(groupPath)' to add file \(file.lastPathComponent)")
                        continue
                    }
                    usingRootGroup = false
                    group = grp
                }
                if group.file(atPath: file.lastPathComponent) == nil {
                    var addLocation: AddLocation<XcodeFileResource> = .end
                    if usingRootGroup {
                        addLocation = .index(indexAfterLastPackagFile)
                        indexAfterLastPackagFile += 1
                    }
                    try group.addExisting(filePath, atLocation: addLocation, savePBXFile: false)
                }
                
                
            }
        }
        
        let removeReferences: [String] = ["DerivedData", "build"]
        for reference in removeReferences {
            let referencePath = xcodeProject.projectFolder.appendingFileComponent(reference)
            if try xcodeProject.fsProvider.itemExists(at: referencePath) {
                var group: XcodeGroup = xcodeProject.resources
                if let idx = reference.lastIndex(of: "/") { // If we find that the file is in a sub folder we must find the sub group
                   let groupPath = String(reference[..<idx])
                   guard let grp = xcodeProject.resources.group(atPath: groupPath) else {
                       errPrint("Unable to find group '\(groupPath)' to add file \(reference.lastPathComponent)")
                       continue
                   }
                   group = grp
                }

                if let resource = group.resource(atPath: reference.lastPathComponent) {
                    try resource.remove(deletingFiles: false, savePBXFile: false)
                }
            }
        }
        
        //debugPrint(xcodeProject)
        try xcodeProject.save()
    
        return returnCode
    }
    
    /// Adds dswift files to Xcode Project
    internal static func addDSwiftFilesToTarget(in url: XcodeFileSystemURLResource,
                                                inGroup group: XcodeGroup,
                                                havingTarget target: XcodeTarget,
                                                usingProvider provider: XcodeFileSystemProvider) throws -> Int32 {
        func hasDSwiftSubFiles(in url: XcodeFileSystemURLResource, usingProvider provider: XcodeFileSystemProvider) throws -> Bool {
            let children = try provider.contentsOfDirectory(at: url)

            for child in children {
                // Check current dir for files
                if child.isFile && generator.isSupportedFile(child.path) {
                    return true
                }
            }
            for child in children {
                // Check sub dir for files
                if child.isDirectory {
                    if (try hasDSwiftSubFiles(in: child, usingProvider: provider)) { return true }
                }
            }
            return false
        }
        
        var rtn: Int32 = 0
        
        let children = try provider.contentsOfDirectory(at: url)
        
        for child in children {
            
            //if  dswiftSupportedFileExtensions.contains(child.pathExtension.lowercased()), child.isFile /*child.isPathFile*/ {
            if child.isFile && generator.canAddToXcodeProject(file: child.path) {
                if !(try generator.updateXcodeProject(xcodeFile: child, inGroup: group, havingTarget: target)) {
                    rtn = 1
                }
            }
        }
        
        
        for child in children {
            if child.isDirectory, (try hasDSwiftSubFiles(in: child, usingProvider: provider)) {
                var childGroup = group.group(atPath: child.pathComponents.last!)
                if  childGroup == nil {
                    childGroup = try group.createGroup(withName: child.pathComponents.last!)
                }
                
                let rCode = try addDSwiftFilesToTarget(in: child,
                                                       inGroup: childGroup!,
                                                       havingTarget: target,
                                                       usingProvider: provider)
                
                if rtn == 0 && rCode > 0 { rtn = rCode }
            }
        }
        
        return rtn
        
    }
    
    
    
}
