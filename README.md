# install.sh

Welcome to the ultimate macOS setup script! Are you tired of the tedious process of setting up your Mac from scratch after a fresh install or format? This script is designed to automate the installation of essential apps and configurations, saving you time and effort.

## Features

- **Automated Installation:** Say goodbye to manually installing your favorite software and tools. This script automates the process, making your setup hassle-free.
- **Customizable Configuration:** Tailor the setup to your needs with a customizable configuration file. Choose the software and settings you want with ease.
- **Comprehensive Setup:** From updating macOS, installing Homebrew and essential software, to configuring system preferences and Dock settings, this script covers all bases to get your macOS ready for use.
- **No External Dependencies:** The script runs without the need for any external dependencies, ensuring a smooth setup process.

## What Does It Do?

The script performs a variety of tasks to prepare a macOS machine for use:

- Updates macOS to the latest version.
- Installs Homebrew, the package manager for macOS.
- Installs essential software and applications through Homebrew casks and formulae.
- Offers the choice between installing Node.js via NVM (Node Version Manager) or Homebrew.
- Installs global NPM packages.
- Provides options to install additional software, such as .NET, Firefox Developer Edition, PostgreSQL, MySQL, MongoDB, Epic & Steam, Unity Hub, and Figma.
- Cleans up the installation environment by running `brew cleanup` and other maintenance commands.
- Sets up Git with global username and email configurations.
- Installs VSCode extensions.
- Installs selected apps from the App Store using `mas` (Mac App Store command-line interface).
- Installs and configures ohmyzsh for a better terminal experience.
- Applies custom system settings and Dock configurations to optimize the user experience.
- Automatically updates Homebrew installed packages with a specified frequency.

## Getting Started

1. **Clone this repository** to your local machine.
2. **Modify `config` file:**

- Adjust `CASKS`, `FORMULAE`, `NPMPACKAGES`, `VSCODE`, and `APPSTORE` sections to select the software you wish to install.
- Change the `SETTINGS` to choose system settings or `DOCK-*` to choose dock setup.

3. **Run the Script:** Open Terminal, navigate to the cloned directory, and execute:

```
./install.sh
```

Follow any on-screen prompts to customize your installation further.

## To Do and Feature Ideas

- **Brewfile Integration:** Add option to use Brewfile if one is present.
- **Improve Prompts:** Refine the prompts for a more intuitive setup experience.
- **Specialized Packages:** Add options for game development, web development packages, etc.
- **Configuration files:** Settings for Apps, Workflows etc.
- **Enhanced User Experience:** Incorporate a checklist (TUI), ASCII graphics during installation.
- **Others:** Include options to log out of FaceTime/Messages automatically.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with suggestions.

Don't forget to give the project a star! Thanks again!

## Acknowledgements

- This script is built by someone tired of the manual setup process and hopes it helps others streamline their macOS setup.
