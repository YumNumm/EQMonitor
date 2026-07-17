# MapLibre classes are resolved by jnigen at runtime, so R8 cannot discover
# every usage from the Android bytecode call graph.
-keep class org.maplibre.android.** { *; }
