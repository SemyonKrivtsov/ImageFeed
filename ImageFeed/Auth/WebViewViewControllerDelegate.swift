//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Семён Кривцов on 03.06.2024.
//

import Foundation

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
