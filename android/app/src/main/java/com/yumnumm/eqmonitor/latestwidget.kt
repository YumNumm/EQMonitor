package com.yumnumm.eqmonitor

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews

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
    val prefs = context.getSharedPreferences("FlutterSharedPrefrences",Context.MODE_PRIVATE)
    // 最新情報を取得
    val max_intensity :String? = prefs.getString("flutter.max_intensity","")
    val place :String? = prefs.getString("flutter.place","太陽")
    val magnitude: String? = prefs.getString("flutter.magnitude","M0.0")
    val time :String? = prefs.getString("flutter.time","2022/03/13 15:00")
    var imageNum:Int = 0
    // image読み込み
    when(max_intensity){
        "0" -> imageNum = R.drawable.int0
        "1" -> imageNum = R.drawable.int1
        "2" -> imageNum = R.drawable.int2
        "3" -> imageNum = R.drawable.int3
        "4" -> imageNum = R.drawable.int4
        "5-" -> imageNum = R.drawable.int5m
        "5+" -> imageNum = R.drawable.int5p
        "6-" -> imageNum = R.drawable.int6m
        "6+" -> imageNum = R.drawable.int6p
        "7" -> imageNum = R.drawable.int7
        else -> imageNum = R.drawable.unknown
    }


    val views = RemoteViews(context.packageName, R.layout.latestwidget)
    // 更新
    views.setImageViewResource(R.id.intensityImageView,imageNum)
    views.setTextViewText(R.id.time,time)
    views.setTextViewText(R.id.placeText,place)
    views.setTextViewText(R.id.magunitudeText,magnitude)
    views.setImageViewResource(R.id.placeIcon,R.drawable.ic_baseline_location_on_24)
    views.setImageViewResource(R.id.magunitudeIcon,R.drawable.ic_baseline_double_arrow_24)
    views.setImageViewResource(R.id.timeicon,R.drawable.ic_baseline_access_time_filled_24)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}
