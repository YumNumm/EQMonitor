# Default Map Labels Design

## Goal

Disable region and city labels by default on the home map.

## Scope

`HomeMapLabelParameter` supplies the defaults used when no saved map-label
preference exists. Change only its `showRegionLabel` and `showCityLabel`
defaults from `true` to `false`.

Previously saved preferences remain unchanged because they are deserialized
from the existing shared-preferences value.

## Validation

Add a model test that verifies a newly constructed parameter disables both
label types while retaining the existing numeric defaults. Run the focused
test and static analysis for the touched files.
