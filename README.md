# Examples

## Notes

Much of my work is owned by the entities I worked for. I've compiled some small portions of my personal projects and/or off the clock work. The goal is to start dropping some things from hackathons, code tests, and more snippets. I'll also try to include things from a lot of different languages.


#### Directories
  - code_examples
    + python
      - national_waze_connector_class.py (A data connector for Waze)
    + shell_scripts
      - install_signal_connector_variables.sh (For getting shared environment credentials from 1password)
      - mac_osx_settings.sh (Automatically setting up a Mac computer with my preferences)
      _ osx_install_functions.sh (Automatically installing all my programs on a Mac)
    + zsh_themes
      - blytzpay.zsh-theme (Built a zsh theme for command line users on my dev team)
      - sethcottam.zsh-theme (Built a personal zsh theme)
  - SpiderBox (Web hosting locally with a web tunnel for shared access)
  - SpryCLI (Command line shell framework)



---

## Code Examples

#### Waze Connector
  _(code_examples/python/national_waze_connector_class.py)_

  We regularly retried data from hundreds of sources. We called them connectors. I built this connector class to demo of a new way of handling connectors.

#### Shared Connector Variables Installer
  _(code_examples/shell_scripts/install_signal_connector_variables.sh)_

  This allowed for connecting to 1password to retrieve shared connector credentials. Since Bash and ZSH don't normally have robust error handling this was a good time to build a more robust shell script for the express purpose of saving my team time.

#### Max OSX Settings
  _(code_examples/shell_scripts/mac_osx_settings.sh)_

  Setting up a new computer can be time consuming. I built this shell to dramatically reduce the time it takes to set up a new mac computer, preferences, dock settings, and more. I use this on every new Mac I get. It saves an incredible amount of time and frustration.
  
#### OSX Install Functions
  _(code_examples/shell_scripts/osx_install_functions.sh)_

  This is for setting all my programs, file stucture, and some command line tools on a new or existing Mac computer. I've modified variations of this for specfic DevOps/IT setups for specific roles. It saves an incredible amount of time and frustration.

#### BlytzPay ZSH Theme
  _(code_examples/zsh_themes/blytzpay.zsh-theme)_

  A newer example of a ZSH Theme I built for one of my Dev teams

  ![SpryCLI Autoloading Development Mode](https://github.com/sethcottam/code_examples/blob/main/screenshots/blytzpay.zsh-theme.png?raw=true)

#### Personal ZSH Theme
  _(code_examples/zsh_themes/sethcottam.zsh-theme)_

  A newer example of a ZSH Theme I built for one of my Dev teams

  ![SpryCLI Autoloading Development Mode](https://github.com/sethcottam/code_examples/blob/main/screenshots/sethcottam.zsh-theme.png?raw=true)

---

## Repo Examples

#### SpiderBox
  [GitHub - SpiderBox](https://github.com/SethCottam/SpiderBox)

  A tunnel to connect the web. This was a fairly quick setup to allow others to easily share a simple local host with other people/teammates without the need for a shared development server. This allows local hosting to be accessible via the web. It currently works best for webhosting with HTML, CSS, and Javascript.

#### SpryCLI (Early Access Demo)
  [GitHub - SpryCLI](https://github.com/SethCottam/SpryCLI_early_access)

  This is a ZSH command line framework to allow simple scripts to automatically load into your shell for an attractive and helpful CLI experience. This is my favorite tool. The framework including installing, auto-loading scripts, formating, outputs, stats, counters, error handling, verbosity settings, searching, specialized git management, and more.

  I was going to build it in Python (which is a far better language for this), but ZSH was more challenging and I wanted to really improve my shell scripting to better round out my full stack expertise.

  This is the framework only version. My personal version has:
  - 179 aliases
  - 694 functions
  - 45 function familes (groups of functions towards the same general purpose, ex. statistics)
  - 23 independent shell scripts
  - 13281 lines of code

  - On my new Mac I've only used it 336 times (thousands on my last Mac). It only counts when I initiate a command, not nested commands, or commands run by the system automatically.

  _Note: I'm transitioning script management from to a newer methodology to make it easier to maintain a personal repo for those scripts outside of the SpryCLI framework. That is a work in progress._

  ![SpryCLI Autoloading Development Mode](https://github.com/sethcottam/code_examples/blob/main/screenshots/SpryCLI-autoloading-development-mode.png?raw=true)


---