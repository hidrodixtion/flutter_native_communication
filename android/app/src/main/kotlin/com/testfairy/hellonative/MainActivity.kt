package com.testfairy.hellonative

import android.os.Bundle
import com.afollestad.materialdialogs.MaterialDialog
import com.afollestad.materialdialogs.Theme
import com.google.gson.Gson
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.jetbrains.anko.startActivity
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class MainActivity : FlutterActivity() {
    private lateinit var service: IService

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        initFlutterChannel()
    }

    private fun initRetrofitService(baseUrl: String) {
        val retrofit = Retrofit.Builder().baseUrl(baseUrl)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
        service = retrofit.create(IService::class.java)
    }

    private fun initFlutterChannel() {
        val channel = MethodChannel(flutterView, "flutter.testfairy.com/hello")
        channel.setMethodCallHandler { methodCall, result ->
            val args = methodCall.arguments as List<*>
            val param = args.first() as String

            when (methodCall.method) {
                "openPage" -> openSecondActivity(param)
                "showDialog" -> showDialog(param, result)
                "request" -> callService(param, result)
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

    private fun callService(url: String, channelResult: MethodChannel.Result) {
        val dialog = MaterialDialog.Builder(this)
                .theme(Theme.LIGHT)
                .title("Getting Data")
                .progress(true, 0)
                .progressIndeterminateStyle(true)
                .build()
        dialog.show()

        initRetrofitService(url)
        service.getEPLTeams().enqueue(object : Callback<TeamResponse> {
            override fun onFailure(call: Call<TeamResponse>?, t: Throwable?) {
                dialog.dismiss()
                channelResult.error("FAILURE", "CALL FAILED", t?.localizedMessage)
            }

            override fun onResponse(call: Call<TeamResponse>?, response: Response<TeamResponse>?) {
                dialog.dismiss()
                channelResult.success(Gson().toJson(response?.body()?.teams))
            }
        })
    }
}
