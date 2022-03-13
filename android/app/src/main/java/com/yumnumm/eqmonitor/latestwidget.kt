package com.yumnumm.eqmonitor

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.net.Uri
import android.content.SharedPreferences
import android.widget.RemoteViews
import com.yumnumm.eqmonitor.MainActivity

class latestwidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    var time = context.getString(R.string.time)
    var place = context.getString(R.string.place)
    var magnitude = context.getString(R.string.magnitude)
    var max_intensity = context.getString(R.string.max_intensity)
    max_intensity = "震度100"
        // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.latestwidget)
    views.setImageViewUri(R.id.intensityImageView,Uri.parse(""))
    // views.setTextViewText(R.id.appwidget_text, widgetText)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}