import catppuccin
import dracula.draw


# load your autoconfig, use this, if the rest of your config is empty!
config.load_autoconfig()


# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows
catppuccin.setup(c, "mocha", True)


config.bind(
    ",dr",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/darculized/darculized-all-sites.css ""',
)

config.bind(
    ",da",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css "" ',
)
