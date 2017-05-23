//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by 小林理恵 on 2017/05/22.
//  Copyright © 2017年 小林理恵. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // ホームページのURL。起動時にこのページを開く。
    let homeUrl = "http://www.yahoo.co.jp"
    
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
    
    // MARK: UlWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView){
//        activityIndicator.alpha = 1
        activityIndicator.isHidden = false
        
        activityIndicator.startAnimating()
        backButton.isEnabled = false
        reloadButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        activityIndicator.alpha = 0
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        backButton.isEnabled = webView.canGoBack
        reloadButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    // MARK: IBAction
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func stopButtonTapped(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
}

