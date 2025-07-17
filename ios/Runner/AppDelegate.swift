import Flutter
import UIKit
import WebKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let loginBrowserChannel = FlutterMethodChannel(name: "comnote.spamix.se/loginBrowser", binaryMessenger: controller.binaryMessenger)
        loginBrowserChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result) -> Void in
            guard call.method == "openLogin" else {
                result(FlutterMethodNotImplemented);
                return;
            }

            self?.openLogin(controller, result: result);
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func openLogin(_ controller: FlutterViewController, result: @escaping FlutterResult) {
        let loginBrowser = LoginBrowserController(callback: { cbResult in
            if cbResult["code"] as! String == "failure" {
                result(FlutterError(
                    code: "ERROR",
                    message: "Unknown webview error",
                    details: nil
                ))
            }
            
            result(cbResult as [String: Any]);
        });
        
        controller.present(loginBrowser, animated: true)
    }
}


class LoginBrowserController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!;
    var callback: ([String: Any])->();
    
    init(callback: @escaping ([String: Any]) -> ()) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let webStore = WKWebsiteDataStore.nonPersistent() // We don't need it to be persistent, it is only used for this and ONLY this login session

        webConfiguration.websiteDataStore = webStore
        webConfiguration.preferences.javaScriptEnabled = true

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self;

        view = webView;
        
        /* COOKIES */
        guard let logSessionIDCookie = HTTPCookie(properties: [
            .domain: "myanimelist.net",
            .name: "MALHLOGSESSID",
            .value: "60f9ef8657200853f2fe423172cfc35a",
            .path: "/"
        ]) else {return}
        
        guard let sessionIDCookie = HTTPCookie(properties: [
            .domain: "myanimelist.net",
            .name: "MALSESSIONID",
            .value: "9def02f383171de2e64138f662de3cb4",
            .path: "/"
        ]) else {return}
        
        guard let loggingInCookie = HTTPCookie(properties: [
            .domain: "myanimelist.net",
            .name: "loggin_in",
            .value: "true",
            .path: "/"
        ]) else {return}
        
        guard let loggedInCookie = HTTPCookie(properties: [
            .domain: "myanimelist.net",
            .name: "is_logged_in",
            .value: "1",
            .path: "/"
        ]) else {return}

        let dispatchGroup = DispatchGroup()
        
        let cookies = [logSessionIDCookie, sessionIDCookie, loggingInCookie, loggedInCookie]
        for cookie in cookies {
            dispatchGroup.enter()
            webStore.httpCookieStore.setCookie(cookie) {
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let url = URL(string: "https://myanimelist.net/v1/oauth2/authorize?response_type=code&client_id=df368c0b8286b739ee77f0b905960700&state=ZtdugS6uXn&redirect_uri=net.myanimelist%3A%2F%2Flogin.input&code_challenge=DrHJdVvTfzZ6nq449ih12DtOPzkD0fLPY1AwAp5qcLF&code_challenge_method=plain&force_logout=1") else {
                print("Invalid URL")
                return
            }
            self.webView.load(URLRequest(url: url))
        }
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void
    ) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow);
            return;
        }
        
        if url.scheme == "net.myanimelist" {
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false);
            let code = components?.queryItems?.first(where: {$0.name == "code"})?.value ?? "failure";
            
            callback(["code": code, "verifier": "DrHJdVvTfzZ6nq449ih12DtOPzkD0fLPY1AwAp5qcLF"])
            self.dismiss(animated: true) {
                // Also cleanup:
                webView.navigationDelegate = nil
                webView.removeFromSuperview()
                // Optionally clear data here
            };
            decisionHandler(.cancel)
            
            return
        }
        decisionHandler(.allow)
    }
}
