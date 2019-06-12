# gglaplot 0.0.1.0000

The majority of the changes relate to updates to the underlying style guide, please see that for mor details and advice.

## Theme changes

### `theme_gla()`

* `gla_theme` now accepts "default" and "inverse" instead of "light" and "dark" to avoid confusion with the new "light" and "dark" palettes. If "light" or "dark" are used they'll be changed to the appropriate new value. The default value of this parameter is now "default".
* Text size ratios have been updated.
* A few other minor changes to theme settings

### `get_theme_colours()`

* This function has been removed. It was mainly an internal function. Other package functions which need to know the underlying theme will use "default", unless otherwise specified.

## Palette changes

The available palettes and the colours underlying them have changed, which has necessitated some changes in the `gla_pal()` function.

* `gla_theme` now accepts "default" and "inverse".
* `palette_name` now accepts "core", "light", "dark" and "brand". 
* `main_colours` remains largely unchanged apart from changes to the underlying colours. If no colours are provided the palettes are returned in their default ordering. If more colours are provided than are asked for (by `n`) then only the first `n` will be returned. If fewer than `n` are provided, additional colours will be added in the default order. If green and LDN pink are used together a warning is returned as these colours are not easily distinguishable.
* `n` should always be the number of colours you want returned. For all palettes except "highlight" this should be a single integer. For "highlight" palettes it should be a vector of 2 integers, the first number of categories you want highlighted, and the second the number of context categories. For "diverging" palettes `n` must be odd or even depending on the combination of `inc0` and `remove_margin`, a warning will be given and `n` adjusted upwards if needed,
* `remove_margin` has been added for diverging and quantitative palettes. To be used to remove the edges of palettes if they are too light or dark. Can be set to "left", "right", "both" or `NULL` (the default). Will remove 1 colour from the appropriate end of the palette, still returning `n` colours in total.
* `muted` has been removed as a paramter - similar palettes can now be accessed by specifying `palette_name = "dark"`.

`gla_pal()` now uses the `chroma` function `interp_scale` instead of `grDevices::colorRampPalette`. The original `chroma` package is available from github [here](https://github.com/jiho/chroma) and is designed to emulate the [chroma.js](https://github.com/gka/chroma.js/) javascript library. `gglaplot` uses a [forked version of this repo](https://github.com/LiRogers/chroma) that includes a the option to correct the lightness scale of a palette.

## Plot function changes

### `ggla_axis_at_0()`, `ggla_donut()`, `ggla_highlightarea()`, `ggla_horizbar()`, `ggla_labelline()` and  `ggla_sf()`

* Now accept a `gla_theme` parameter.

# gglaplot 0.0.0.9000

* This is the first release of gglaplot
