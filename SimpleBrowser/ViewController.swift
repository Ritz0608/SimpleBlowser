//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by 小林理恵 on 2017/05/22.
//  Copyright © 2017年 小林理恵. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // ホームページのURL。起動時にこのページを開く。
    let homeUrl = "http://www.yahoo.co.jp"
    
    // 検索機能で使うURL
    let seachURL = "http://search.yahoo.co.jp/search?p="
    
    // MARK:-UISeachBaraDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            let url = seachURL + searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            print(url)
            openUrl(urlString: url)
            searchBar.resignFirstResponder()
        }
    }
    
    // URLのホワイトリスト。
    // このURLにあてはまればアプリ内ブラウザで表示可能。
    // 前方一致の正規表現で処理される。
    let whiteList = [
        "https?://.*\\.yahoo\\.co\\.jp",
        "https?://.*\\.yahoo\\.com",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ホームページを開く
        openUrl(urlString: homeUrl)
    }
    
    // 文字列で指定されたURLをWebViewで開く
    func openUrl(urlString: String) {
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        webView.loadRequest(urlRequest)
    }
    
    // 文字列で指定されたURLをsafariで開く。
    func openUrlInsafari(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.openURL(url)
        }
    }
    
    // 読込完了時の処理
    func stopLoading(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        backButton.isEnabled = webView.canGoBack
        reloadButton.isEnabled = true
        stopButton.isEnabled = false
        webView.stopLoading()
    }
    
    // MARK: - UlWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request:
        URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // ユーザの操作によるリクエストでなければ表示許可。
        if navigationType == .other {
            return true
        }
        
        // 現在表示中のURLを取得
        guard let urlString = request.url?.absoluteString else {
            //　現在表示中のURLが取得できない場合表示不許可
            stopLoading()
            return false
        }
        
        // ホワイトリストでループしてURLがホワイトリスト内にあるかチェック。
        var canStayInAPP = false
        for url in whiteList {
            if urlString.range(of: url, options: .regularExpression) != nil {
                canStayInAPP = true
                break
            }
        }
        
        //  ホワイトリスト内に無ければSafariで開く。
        if !canStayInAPP {
            openUrlInsafari(urlString: urlString)
            stopLoading()
            return false
        }
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        backButton.isEnabled = false
        reloadButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        stopLoading()
    }
    
    // MARK: - IBAction
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func stopButtonTapped(_ sender: UIBarButtonItem) {
        stopLoading()
    }
}
