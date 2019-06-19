# gglaplot 1.0.0

The majority of the changes relate to updates to the underlying style guide, further details and advice can be found [here](https://data.london.gov.uk/blog/city-intelligence-data-design-guidelines/), and updates to ggplot2. The package now depends on [ggplot2 v3.2](https://github.com/tidyverse/ggplot2/tree/v3.2.0).

## Theme changes

* `theme_gla()`
    * `gla_theme` now accepts "default" and "inverse" instead of "light" and "dark" to avoid confusion with the new "light" and "dark" palettes. If "light" or "dark" are used they'll be changed to the appropriate new value. The default value of this parameter is now "default".
    * Text size ratios have been updated.
    * A few other minor changes to theme settings
* `get_theme_colours()`
    * This function has been removed. It was mainly an internal function. Other package functions which need to know the underlying theme will use "default", unless otherwise specified.

## Colour changes

The colours (both names and values) have been changed to match the new version of the style guide. See `gla_colours`, `gla_default` and `gla_inverse` for all the details of the new colours used by the themes and palettes.

## Palette changes

The available palettes and the colours underlying them have changed, which has necessitated some changes in the `gla_pal()` function.

* `gla_theme` now accepts "default" and "inverse". If "light" or "dark" are used they'll be changed to the appropriate new value and a warning given.
* `palette_name` now accepts "core", "light", "dark" and "brand". 
* `main_colours` remains largely unchanged apart from changes to the underlying colours. If no colours are provided the palettes are returned in their default ordering. If more colours are provided than are asked for (by `n`) then only the first `n` will be returned. If fewer than `n` are provided, additional colours will be added in the default order. If green and LDN pink are used together a warning is returned as these colours are not easily distinguishable.
* `n` should always be the number of colours you want returned. For all palettes except "highlight" this should be a single integer. For "highlight" palettes it should be a vector of 2 integers, the first number of categories you want highlighted, and the second the number of context categories. For "diverging" palettes `n` must be odd or even depending on the combination of `inc0` and `remove_margin`, a warning will be given and `n` adjusted upwards if needed,
* `remove_margin` has been added for diverging and quantitative palettes. Can be used to remove the edges of palettes if they are too light or dark. Can be set to "left", "right", "both" or `NULL` (the default). Will remove 1 colour from the appropriate end(s) of the palette, still returning `n` colours in total.
* `muted` has been removed as a paramter - similar palettes can now be accessed by specifying `palette_name = "dark"`.

`gla_pal()` now uses the `chroma` function `interp_scale` instead of `grDevices::colorRampPalette`. The original `chroma` package is available from github [here](https://github.com/jiho/chroma) and is designed to emulate the [chroma.js](https://github.com/gka/chroma.js/) javascript library. `gglaplot` uses a [forked version of this repo](https://github.com/LiRogers/chroma) that includes the option to correct the lightness scale of a palette. This version will be installed automatically when the package is updated/installed.

## Plot function changes

* `ggla_highlight()`
    * Now uses the settings for `gla_default` unless `gla_inverse` has been set using `theme_set()`
    * Uses `blue_core` as its default colour.
*`ggla_line()`
    * Uses `blue_core` as its default colour.
    * Default size set to 3pt.
* `ggla_sf()`
    * This function has been overhauled due to underlying changes in ggplot2 v3.2 which makes extending the ggplot function `geom_sf()` a lot easier.
    * The geometry aesthetic **must** be set (this is due to a change in ggplot).
    * Sensible default aesthetics are set for different geometries:
        * `blue_core`  as the default colour for point and line geometries.
        * Default size set to 3pt for point and line geometries.
        * The neutral `mid point` colour as the default fill for polygons
        * The theme `background` as the default colour (used for polygon outlines).
    * Will use the settings for `gla_default` unless `gla_inverse` has been set using `theme_set()`
* The following now accept `gla_theme` as a parameter (set to "default"" as default)
    * `ggla_axis_at_0()`
    * `ggla_donut()`
    * `ggla_highlightarea()`
    * `ggla_horizbar()`
    * `ggla_labelline()`

    

# gglaplot 0.0.0.9000

* This is the first release of gglaplot
