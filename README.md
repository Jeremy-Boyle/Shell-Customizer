# Shell Customizer 

This shell script automates the install for zsh with oshmyzsh and themeing
## Required
Debian based Linux, more flavors will be added at a later date
```bash
sudo apt-get install curl
```

Mac OSX
 with brew preinstalled [information to install brew](https://docs.brew.sh/Installation)

## Fonts



#### Automatic font installation

If you are using iTerm2 or Termux, `p10k configure` can install the recommended font for you.
Simply answer `Yes` when asked whether to install *Meslo Nerd Font*.

If you are using a different terminal, proceed with manual font installation. 👇

#### Manual font installation

Download the hacked font file:

- [AFCSoftwareFactory-Regular.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)

Double-click on each file and click "Install". This will make `MesloLGS NF` font available to all
applications on your system. Configure your terminal to use this font:

- **iTerm2**: Type `p10k configure` and answer `Yes` when asked whether to install
  *Meslo Nerd Font*. Alternatively, open *iTerm2 → Preferences → Profiles → Text* and set *Font* to
  `MesloLGS NF`.
- **Apple Terminal**: Open *Terminal → Preferences → Profiles → Text*, click *Change* under *Font*
  and select `MesloLGS NF` family.
- **Hyper**: Open *Hyper → Edit → Preferences* and change the value of `fontFamily` under
  `module.exports.config` to `MesloLGS NF`.
- **Visual Studio Code**: Open *File → Preferences → Settings*, enter
  `terminal.integrated.fontFamily` in the search box and set the value to `MesloLGS NF`.
- **GNOME Terminal** (the default Ubuntu terminal): Open *Terminal → Preferences* and click on the
  selected profile under *Profiles*. Check *Custom font* under *Text Appearance* and select
  `MesloLGS NF Regular`.
- **Konsole**: Open *Settings → Edit Current Profile → Appearance*, click *Select Font* and select
  `MesloLGS NF Regular`.
- **Tilix**: Open *Tilix → Preferences* and click on the selected profile under *Profiles*. Check
  *Custom font* under *Text Appearance* and select `MesloLGS NF Regular`.
- **Windows Console Host** (the old thing): Click the icon in the top left corner, then
  *Properties → Font* and set *Font* to `MesloLGS NF`.
- **Microsoft Terminal** (the new thing): Open *Settings* (`Ctrl+,`), search for `fontFace` and set
  value to `MesloLGS NF` for every profile.
- **IntelliJ** (and other IDEs by Jet Brains): Open *IDE → Edit → Preferences → Editor →
  Color Scheme → Console Font*. Select *Use console font instead of the default* and set the font
  name to `MesloLGS NF`.
- **Termux**: Type `p10k configure` and answer `Yes` when asked whether to install
  *Meslo Nerd Font*.
- **Blink**: Type `config`, go to *Appearance*, tap *Add a new font*, tap *Open Gallery*, select
  *MesloLGS NF.css*, tap *import* and type `exit` in the home view to reload the font.
- **Terminus**: Open *Settings → Appearance* and set *Font* to `MesloLGS NF`.
- **Terminator**: Open *Preferences* using the context menu. Under *Profiles* select the *General*
  tab (should be selected already), uncheck *Use the system fixed width font* (if not already)
  and select `MesloLGS NF Regular`. Exit the Preferences dialog by clicking *Close*.
- **Guake**: Right Click on an open terminal and open *Preferences*. Under *Appearance*
  tab, uncheck *Use the system fixed width font* (if not already) and select `MesloLGS NF Regular`.
  Exit the Preferences dialog by clicking *Close*.
- **MobaXterm**: Open *Settings* → *Configuration* → *Terminal* → (under *Terminal look and feel*)
  and change *Font* to `MesloLGS NF`.
- **Asbrú Connection Manager**: Open *Preferences → Local Shell Options → Look and Feel*, enable
  *Use these personal options* and change *Font:* under *Terminal UI* to `MesloLGS NF Regular`.
  To change the font for the remote host connections, go to *Preferences → Terminal Options →
  Look and Feel* and change *Font:* under *Terminal UI* to `MesloLGS NF Regular`.
- **WSLtty**: Right click on an open terminal and then on *Options*. In the *Text* section, under
  *Font*, click *"Select..."* and set Font to `MesloLGS NF Regular`.
- **Alacritty**: Create or open `~/.config/alacritty/alacritty.yml` and add the following section
  to it:
  ```yaml
  font:
    normal:
      family: "MesloLGS NF"
  ```
 - **Kitty**: Create or open `~/.config/kitty/kitty.conf` and add the following line to it:
   ```text
   font_family MesloLGS NF
   ```
   Restart Kitty by closing all sessions and opening a new session.
- **WezTerm**: Create or open `$HOME/.config/wezterm/wezterm.lua` and add the following:
  ```lua
  local wezterm = require 'wezterm';
  return {
      font = wezterm.font("MesloLGS NF"),
  }
  ```
  If the file already exists, only add the line with the font to the existing return. 
  Also add the first line if it is not already present.
- **urxvt**: Create or open `~/.Xresources` and add the following line to it:
   ```text
   URxvt.font: xft:MesloLGS NF:size=11
   ```
  You can adjust the font size to your preference. After changing the configuration use `xrdb ~/.Xresources` to reload the config. 
  The new config is applied for all new terminals.

**IMPORTANT:** Run `p10k configure` after changing terminal font. The old `~/.p10k.zsh` may work
incorrectly with the new font.

_Using a different terminal and know how to set the font for it? Share your knowledge by sending a
PR to expand the list!_


## Installation

Use curl to run the script.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Jeremy-Boyle/Shell-Customizer/main/custom_shell.sh)"
```

If you are on a linux machine and your current shell is NOT zsh you will need admin rights to install zsh. Otherwise use the command above
```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/Jeremy-Boyle/Shell-Customizer/main/custom_shell.sh)"
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)