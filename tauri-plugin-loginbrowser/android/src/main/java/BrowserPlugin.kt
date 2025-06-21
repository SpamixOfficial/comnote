package com.plugin.login_browser

import android.app.Activity
import app.tauri.annotation.Command
import app.tauri.annotation.InvokeArg
import app.tauri.annotation.TauriPlugin
import app.tauri.plugin.JSObject
import app.tauri.plugin.Plugin
import app.tauri.plugin.Invoke

@InvokeArg
class PingArgs {
  var value: String? = null
}

@TauriPlugin
class BrowserPlugin(private val activity: Activity): Plugin(activity) {
    private val implementation = Browser()
    @Command
    fun openLogin(invoke: Invoke) {
      val ret = JSObject()
      ret.put("code", implementation.openLogin(activity))
      invoke.resolve(ret)
    }
}
