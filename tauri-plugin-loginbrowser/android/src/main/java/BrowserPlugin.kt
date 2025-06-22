package com.plugin.login_browser

import android.app.Activity
import app.tauri.annotation.Command
import app.tauri.annotation.InvokeArg
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.JSObject
import app.tauri.plugin.Plugin
import app.tauri.plugin.Channel
import app.tauri.plugin.Invoke

@InvokeArg
class PingArgs {
  var value: String? = null
}

@InvokeArg
class LoginArgs {
  lateinit var channel: Channel
}

data class LoginData(
  val code: String,
  val verifier: String
)

@TauriPlugin
class BrowserPlugin(private val activity: Activity): Plugin(activity) {
    private val implementation = Browser()

    @Command
    fun openLogin(invoke: Invoke) {
      val args = invoke.parseArgs(LoginArgs::class.java)

      implementation.openLogin(activity, { x -> args.channel.send(createLoginData(x))})
    }

    private fun createLoginData(data: LoginData): JSObject {
      var ret = JSObject()

      ret.put("code", data.code)
      ret.put("verifier", data.verifier)

      return ret
    }
}
