package com.testfairy.hellonative

import android.os.Bundle
import com.afollestad.materialdialogs.MaterialDialog
import com.afollestad.materialdialogs.Theme

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.jetbrains.anko.alert
import org.jetbrains.anko.noButton
import org.jetbrains.anko.startActivity
import org.jetbrains.anko.yesButton

class MainActivity() : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        initFlutterChannel()
    }

    private fun initFlutterChannel() {
        val channel = MethodChannel(flutterView, "flutter.testfairy.com/hello")
        channel.setMethodCallHandler { methodCall, result ->
            val args = methodCall.arguments as List<*>
            val param = args.first() as String

            when (methodCall.method) {
                "openPage" -> openSecondActivity(param)
                "showDialog" -> showDialog(param, result)
                "request" -> callService(param)
                else -> return@setMethodCallHandler
            }
        }
    }

    private fun openSecondActivity(info: String) {
        startActivity<SecondActivity>("info" to info)
    }

    private fun showDialog(content: String, channelResult: MethodChannel.Result) {
//        alert(content, "Native Dialog") {
//            yesButton { channelResult.success("Ok was pressed") }
//            noButton { channelResult.success("No was pressed") }
//        }.show()

        MaterialDialog.Builder(this).title("Native Dialog")
                .content(content)
                .theme(Theme.LIGHT)
                .positiveText("Ok")
                .negativeText("Cancel")
                .onPositive { _, _ -> channelResult.success("Ok was clicked") }
                .onNegative { _, _ -> channelResult.success("Cancel was clicked") }
                .show()
    }

    private fun callService(url: String) {

    }
}
