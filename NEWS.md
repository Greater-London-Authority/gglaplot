# gglaplot 1.1.0

Changes relate to new functionality in ggplot2 3.3 and new functions to apply gglaplot style to plotly plots. The package now depends on [ggplot2 v3.3](https://github.com/tidyverse/ggplot2/tree/v3.3.0).

## New features
* gglaplot style can now be added to plotly plots by `%>%` it into `ggla_plotly_settings()`. This adjust the plotly `layout`, `style` and `config` settings. Each of these can applied seperately (and adjusted with addtional arguments) with `ggla_plotly_layout()`, `ggla_plotly_style()` and `ggla_plotly_config()`. (#23)

## Major changes
* `left_align_labs()` is being deprecated. The functionality to fully left align titles, subtitles and captions is now included in `theme_gla()`. [Left aligning the legend is an open issue in ggplot2 which will be resolved in v3.4](https://github.com/tidyverse/ggplot2/issues/4020).
* y-axis labels now sit on tick marks. A default value for the length is set which should work for most plots. For plots with particularly long y-axis labels or a y-axis title the tick mark length can be adjusted with `y_label_length` in `theme_gla()`. (#21)
* `theme_gla()` now includes a boolean arguement `free_y_facets`. This should be used for faceted plots with free scales on the y axis. This changes the position of the y-axis labels 

## Bug fixes
* Issues with overlapping legends, titles, plots resolved. (#24)


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

## Plot function and geometric object changes:

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
* New Geomtric objects that have default aesthetics inline with the style guide (aesthetics can be overwritten as normal):
    * `GeomGLALine` for use with `ggla_line()` (set as default).
    * `GeomGLATextHighlight` for use with `ggla_highlight()` when adding labels (existing `GeomGLAPointHighlight` set as default). Should be specified with `geom = GeomGLATextHighlight`.
    * `GeomGLAAnnotate` for use with `ggplot2::annotate()`. Should be specified with `geom = GeomGLAAnnotate`.
    * `GeomGLASf` for use with `ggla_sf()` (set as default).
  

# gglaplot 0.0.0.9000

* This is the first release of gglaplot.
