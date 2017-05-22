//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by 小林理恵 on 2017/05/22.
//  Copyright © 2017年 小林理恵. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    
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
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func stopButtonTapped(_ sender: UIBarButtonItem) {
    }
}

