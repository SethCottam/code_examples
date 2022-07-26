#!/bin/zsh

  ##############################################################################################
 ########  User Signal Connectors Variables                                            ########
##############################################################################################
#
# Description - OPTIONAL Global Variables for Signal Connectors. These will overwrite dfaults.
#   These are user specific to allow for better flexibility in usage.
# Note - This is currently optimized for ZSH on MAC OSX
# Dependencies - ZSH (or possibly Bash), 1password-cli (op), Brew and Cask (Only if 1pass
#   wans't previously installed)
# Status - Work in Progess

# Private for testing purposes TODO: Update this 
VAULT_NAME="Signals Team"  # Note: The name is NOT case sensitive
VARIABLES_FILENAME=".signal_connectors_variables"
VARIABLES_FILEPATH="$HOME/.signal_connectors_variables"
USER_VARIABLES_FILENAME=".user_signal_connectors_variables"
USER_VARIABLES_FILEPATH="$HOME/.user_signal_connectors_variables"
BANJO_1PASS_URL="banjo.1password.com"

login_attempts=0


##############################################################################################
####  Format Functions
##############################################################################################
# Because we all love pretty outputs

# Standard colors 
SUCCESS='\033[0;32m'    # Green
WARNING='\033[0;33m'    # Yellow
ERROR='\033[0;31m'      # Red
INFO='\033[01;34m'      # Blue
UNIQUE='\033[00;35m'    # Light Purple
CASUAL='\033[02;37m'    # Grey
DEBUG1='\033[00;36m'    # Light Blue
DEBUG2='\033[02;36m'    # Teal
RESET='\033[0m'         # Back to Default

info() {
    # Colors a single sentance in Blue
    echo -e "${INFO}${1}${RESET}"
}

success() {  
    # Formats and colors [SUCCCES] and colors a single sentance.    
    echo -e "[${SUCCESS}SUCCESS${RESET}] ${CASUAL}${1}${RESET}"

}  

warning() {  
    # Formats and colors [WARNING] and colors a single sentance. 
    echo -e "[${WARNING}WARNING${RESET}] ${CASUAL}${1}${RESET}"
}  

error() {    
    # Formats and colors [ERROR] and colors a single sentance.   
    echo -e "[${ERROR}ERROR${RESET}] ${CASUAL}${1}${RESET}" 
}

prompt() {
    # Formats and colors asking the user for information
    echo -e "${DEBUG1}USER INPUT${RESET}: ${CASUAL}Please type your ${DEBUG1}${1}${RESET} ${CASUAL}and press${RESET} ${WARNING}[ENTER]${RESET}"
}

##############################################################################################
####  Installation Functions
##############################################################################################
# The core of what this shell script is trying to accomplish

# TODO: We need to verify that op is installed. If not we need to do a simple install
# echo $SHELL if /bin/zsh we're good to go if /bin/bash we need to warn them that we havne't built it out yet

installation() {
    # Walks through the installation dependancies and installation
    info "\nAttempting to install the Signal Connectors Variables from 1password\n"

    # Validates we can install on this shell
    check_shell
    # Checks if 1Password CLI has been installed, may attempt installation if necessary
    check_op
    # Check the 1Password CLI session and logs in if necessary
    check_login_op
    # Gets the get_signal_connector_variables files and places them in in your $HOME dir
    get_signal_connectors_variables
    get_user_signal_connectors_variables
    # Ensures they're loaded into your shell on start
    source_files
    
    success "INSTALLATION COMPLETE!\n"
}

check_shell() {
    info "Determining which shell you're using"
    result=$(echo $SHELL 2>&1)
    # echo -e "Result: ${result} END OF RESULT"
    if [[ ${result} =~ "/bin/zsh"  ]]; then
        success "ZSH is a compatible shell"
    elif [[ ${result} =~ "/bin/bash" ]]; then
        error "Bash is not currently a compatible shell" 
        installation_failure
    else
        error "Our script is unfamiliar with the shell \"${result}\""
        installation_failure
    fi
}

check_op() {
    # Basic check to see if OP is already installed
    info "Determining if 1password-cli has been installed"
    result=$(op 2>&1)
    # echo -e "Result: ${result} END OF RESULT"
    if [[ ${result} =~ "The 1Password command-line tool provides"  ]]; then
        success "The 1Password CLI is operational"
    elif [[ ${result} =~ "command not found" ]]; then
        warning "The 1Password CLI has not been installed" 
        check_brew
    else
        error "Unknown issues: ${result}"
        installation_failure
    fi
}

check_brew() {
    # Basic check to see if HomeBrew is already installed
    info "Determining if HomeBrew has been installed"

    result=$(brew -h 2>&1)
    if [[ ${result} =~ "brew search"  ]]; then
        success "HomeBrew is operational"
        check_brew_cask
    elif [[ ${result} =~ "command not found" ]]; then
        warning "Homebrew has not been installed"
        # TODO: Attempt to install brew
        check_brew_cask
    else
        error "Unknown issues: ${result}" 
        installation_failure
    fi
}

check_brew_cask() {
    # Basic check to see if HomeBrew Cask is already installed
    info "Determining if HomeBrew Cask has been installed"

    result=$(brew cask 2>&1)
    if [[ ${result} =~ "man brew-cask"  ]]; then
        success "HomeBrew Cask is operational"
        install_op
    elif [[ ${result} =~ "command not found" ]]; then
        warning "Homebrew Cask has not been installed"
        # TODO need an install hombrew cask
        install_op
    else
        error "Unknown issues: ${result}" 
        installation_failure
    fi
}

install_op() {
    # Install 1Password CLI
    info "Attempting to install 1password-cli. This may take awhile. Installation will require your computer password."

    formulae="1password-cli"

    result=$(brew cask install $formulae 2>&1)
    # We want them to see the output
    echo $result
    if [[ ${result} =~ "successfully installed"  ]]; then
        success "The 1Password CLI has been installed"
        # Need to set up the initial signin
        signin_op
    elif [[ ${result} =~ "is already installed" ]]; then
        # Shouldn't be able to get here based on previous checks, but added it in case
        success "The 1Password CLI is operational"
    elif [[ ${result} =~ "Account not found" ]]; then
        warning "Unable to find the 1password account"
        signin_op
    elif [[ ${result} =~ "is unavailable" ]]; then
        warning "This Homebrew Cask \"${formulae}\" no-longer exists under that name"
        installation_failure
    else
        error "Unknown issues: ${result}" 
        installation_failure
    fi
}

signin_op() {
    # This is intended for first time signins but won't hurt or help anything by doing it again
    info "Attempting the initial login of 1Password through the CLI"

    # Unfortunatly we need to get the email address and the 1pass password to build the command
    prompt '1password Username'
    read username
    # TODO: Need a way to verify and validate this or send them back to signin_op
    # prompt '1password Password'
    # read -s username

    # TODO: Need to validate usage and build out checks so it can't continue without it
    result=$(op signin $BANJO_1PASS_URL $username)

    # echo $result
    if [[ ${result} =~ "successfully installed"  ]]; then
        success "The 1Password CLI has been installed"
        # Need to set up the initial signin
        signin_op
    elif [[ ${result} =~ "command-line tool provides commands to manage" ]]; then
        # Both the url and username were blank
        error "Both the script's 1password url and username were left blank. Cannot proceed."
        installation_failure
    elif [[ ${result} =~ "export OP_SESSION_" ]]; then
        # It has installed but needs to run the export command 
        # Example: export OP_SESSION_banjo="XXXXXXXXXXX"
        # We need to tranform the multiline string into an array and execute the first line
        array_of_lines=("${(@f)${result}}")
        eval ${array_of_lines[1]}
        success "Established session using: $array_of_lines[1]"
    else
        error "Unknown issues: ${result}" 
        installation_failure
    fi
    

    # Immediately unset so it can't be used anywhere else in the script
    unset username #password
}

login_op() {
    # This is your standard login session

    # TODO: Need to validate what happens when `op signin` has NOT happened yet!

    if [[ ${login_attempts} < 3  ]]; then
        info "Attempting to login to 1Password using the CLI" 
        # TODO: Need to try to login and loop back to itself if there is a failure
        # Example: [LOG] 2020/05/08 01:06:39 (ERROR)  401: Authentication required.
        result=$(op signin banjo)

        ((login_attempts++))

        if [[ ${result} =~ "uuid"  ]]; then # uuid  # this is wrong
            success "Connected to 1Password through the CLI"
        elif [[ ${result} =~ "Account not found" ]]; then
            warning "Unable to find the 1password account"
            signin_op
        elif [[ ${result} =~ "export OP_SESSION_" ]]; then
            # It has installed but needs to run the export command 
            # Example: export OP_SESSION_banjo="XXXXXXXXXXX"
            # We need to tranform the multiline string into an array and execute the first line
            array_of_lines=("${(@f)${result}}")
            eval ${array_of_lines[1]}
            success "Established session using: $array_of_lines[1]"
        else
            error "Unknown issues: ${result}. Retrying."
            signin_op
        fi
        
    else
        error "Too many session login attempts"
        installation_failure
    fi
}

check_login_op() {
    # Verify we've logged in
    info "Attempting to verify the login session"

    result=$(op list items --vault $VAULT_NAME 2>&1)  # private is a default for all users

    # TODO: need to verify this on an empty vault to see what comes back on a successful call
    if [[ ${result} =~ "uuid"  ]]; then # uuid
        success "Connected to 1Password through the CLI"
    elif [[ ${result} =~ "session expired" ]]; then
        warning "Unsuccessful login attempt. Retrying!"
        warning "Login Attempts: $login_attempts"
        login_op
    elif [[ ${result} =~ "not currently signed in" ]]; then
        warning "Unsuccessful login attempt. Retrying!"
        warning "Login Attempts: $login_attempts"
        login_op
    elif [[ ${result} =~ "timeout" ]]; then
        warning "Unsuccessful login attempt due to time out. Retrying!"
        warning "Login Attempts: $login_attempts"
        login_op
    else
        error "Unknown issues: ${result}"
        installation_failure
    fi
}

get_signal_connectors_variables() {
    # Get the signal connector varibles file and overwrite the existing file if it exists
    info "Attempting to retrieve and create the Variables file"

    # TODO: A failure create an empty file that will overwrite an existing file... so we need
    #   to be positive it is there BEFORE we attempt to write it. Not efficient, but it's safe

    result=$(op get document $VARIABLES_FILENAME --vault $VAULT_NAME 2>&1)

    # This one is tricky since the file is prone to change. If there are no errors we continue.
    if [[ ${result} =~ "no item found"  ]]; then
        error "File missing or moved"
        echo $result
        installation_failure
    elif [[ ${result} =~ "session expired" ]]; then
        warning "Unsuccessful login attempt. Retrying!"
        login_op
    elif [[ ${result} =~ "not currently signed in" ]]; then
        warning "Unsuccessful login attempt. Retrying!"
        login_op
    elif [[ ${result} =~ "timeout" ]]; then
        warning "Unsuccessful login attempt due to time out. Retrying!"
        login_op
    else
        # Copy the file from the result to the local filepath
        echo $result > $VARIABLES_FILEPATH

        # Count the number of characters in the file, a failure to write data to a file will result in "       0 FILENAME"
        file_check=$(wc -l < $VARIABLES_FILEPATH 2>&1)

        # Make sure it was written successfully 
        if [[ -f "$VARIABLES_FILEPATH" ]] && [[ $file_check -gt "0" ]]; then  # spaces in " 0" is necessary 
            success "Created the file $VARIABLES_FILEPATH"
        else
            error "The file was unable to be written to $VARIABLES_FILEPATH"
            installation_failure
        fi
    fi
}

get_user_signal_connectors_variables() {
    # Get the user signal connector varibles file if it does not already exist
    info "Attempting to retrieve and create the User Variables file"

    # $USER_VARIABLES_FILEPATH

    if [[ -f "$USER_VARIABLES_FILEPATH" ]]; then
        warning "$USER_VARIABLES_FILEPATH already exists. Skipping."
    else 
        result=$(op get document $USER_VARIABLES_FILENAME --vault $VAULT_NAME 2>&1)

        # This one is tricky since the file is prone to change. If there are no errors we continue.
        if [[ ${result} =~ "no item found"  ]]; then
            error "File missing or moved"
            echo $result
            installation_failure
        elif [[ ${result} =~ "session expired" ]]; then
            warning "Unsuccessful login attempt. Retrying!"
            login_op
        elif [[ ${result} =~ "not currently signed in" ]]; then
            warning "Unsuccessful login attempt. Retrying!"
            login_op
        elif [[ ${result} =~ "timeout" ]]; then
            warning "Unsuccessful login attempt due to time out. Retrying!"
            login_op
        else
            # Copy the file from the result to the local filepath
            echo $result > $USER_VARIABLES_FILEPATH

            # Count the number of characters in the file, a failure to write data to a file will result in "       0 FILENAME"
            file_check=$(wc -l < $USER_VARIABLES_FILEPATH 2>&1)

            # Make sure it was written successfully 
            if [[ -f "$USER_VARIABLES_FILEPATH" ]] && [[ $file_check -gt "0" ]]; then  # spaces in " 0" is necessary 
                success "Created the file $USER_VARIABLES_FILEPATH"
            else
                error "The file was unable to be written to $USER_VARIABLES_FILEPATH"
                installation_failure
            fi
        fi
    fi       
}

source_files() {

    check_shell_autoload_files

    source_variables="source \$HOME/$VARIABLES_FILENAME  # Signal Connectors Variables (REQUIRED)"
    source_user_variables="source \$HOME/$USER_VARIABLES_FILENAME # Signal Connectors User Variables (OPTIONAL)"

    result=$(grep $source_variables $HOME/.zshrc 2>&1)

    # TODO: should loop this
    if [[ -z ${result} ]]; then
        # TODO: Should have some actual checks for this
        echo $source_variables >> $HOME/.zshrc
        success "Autoloading of $VARIABLES_FILEPATH enabled"
    else
        warning "Autoloading is already enabled for $VARIABLES_FILEPATH"
    fi

    result=$(grep $source_user_variables $HOME/.zshrc 2>&1)

    if [[ -z ${result} ]]; then
        # TODO: Should have some actual checks for this
        echo $source_user_variables >> $HOME/.zshrc
        success "Autoloading of $USER_VARIABLES_FILEPATH enabled"
    else
        warning "Autoloading is already enabled for $USER_VARIABLES_FILEPATH"
    fi
}

check_shell_autoload_files() {
    # Check if the core shell files exist or create one
    info "Attempting to find autoloaded core shell files to ensure the new files will load automatically"

    # TODO: Should expand this into BASH (.zshrc) and Older OSX (.bash_profile)
    if [[ ! -f "$HOME/.zshrc" ]]; then
        result=$(touch "$HOME/.zshrc" 2>&1)

        if [[ -z ${result} ]]; then
            success "Created $HOME/.zshrc"
        else
            error "Unable to find or create $HOME/.zshrc"
            installation_failure
        fi
    else 
        success "Located $HOME/.zshrc"
    fi
}

installation_failure() {
    error "Unable to complete the installation"
    exit 1
}

##############################################################################################
####  Execution
##############################################################################################
# SEND IT!!!!

installation

##############################################################################################
 ########  User Signal Connectors Variables                                            ########
  ##############################################################################################