package com.plugin.login_browser

import android.app.Activity
import android.util.Log
import android.net.Uri
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.webkit.*
import android.webkit.*
import android.content.Intent

class Browser {
    // will probably change so it returns empty (webview is async)
    fun openLogin(activity: Activity): String {
        // Hardcoded client_id in the app btw
        val url = "https://myanimelist.net/v1/oauth2/authorize?response_type=code&client_id=df368c0b8286b739ee77f0b905960700&state=ZtdugS6uXn&redirect_uri=net.myanimelist&code_challenge=DrHJdVvTfzZ6nq449ih12DtOPzkD0fLPY1AwAp5qcLF&code_challenge_method=plain&force_logout=1"
        val webview: WebView = WebView(activity)

        // Enable cookies
        val cookieManager = CookieManager.getInstance()
        cookieManager.setAcceptCookie(true)
        cookieManager.setAcceptThirdPartyCookies(webview, true)
        // default cookies
        cookieManager.setCookie("https://myanimelist.net", "logging_in=true", null)
        cookieManager.setCookie("https://myanimelist.net", "MALHLOGSESSID=60f9ef8657200853f2fe423172cfc35a", null) // these are hard-coded cookies used by the app on startup, no joke this took me hours to figure out :/
        cookieManager.setCookie("https://myanimelist.net", "MALSESSIONID=9def02f383171de2e64138f662de3cb4", null) // In my defense I thought the cookies were "generated" or fetched on startup so I was searching for some time...
        cookieManager.setCookie("https://myanimelist.net", "is_logged_in=1", null)

        // Enable WebView settings
        webview.settings.javaScriptEnabled = true
        webview.settings.domStorageEnabled = true

        // Create interceptor
        webview.webViewClient = InterceptorClient(activity)

        val layoutParams = FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT
        )

        // load webview
        activity.addContentView(webview, layoutParams)
        webview.loadUrl(url)
    }
}


private class InterceptorClient(private val activity: Activity) : WebViewClient() {
    override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
        val uri = Uri.parse(url)
        println("loofball_v123: [[ ${url} ]] [[ ${uri.getPathSegments()} ]] [[ ${uri.getQueryParameterNames()} ]]")
        // TODO: Forward code to parent to finish setup process
        if (uri.getScheme() == "net.myanimelist" &&  == "login.input") {
            // destroy this webview but keep parent intact
            (view?.parent as? ViewGroup)?.removeView(view)
            return true
        }
        return false
    }
}