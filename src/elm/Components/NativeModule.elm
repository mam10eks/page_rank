module Components.NativeModule exposing (..)

import Components.Model exposing (SvgInformations)
import Native.NativeModule


svgMetrics : () -> SvgInformations
svgMetrics =
    Native.NativeModule.svgMetrics
