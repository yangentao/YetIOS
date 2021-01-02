//
// Created by entaoyang on 2019-02-14.
// Copyright (c) 2019 yet.net. All rights reserved.
//

import Foundation
import UIKit

open class WebViewPage: TitlePage {

	public let webView: UIWebView = UIWebView(frame: Rect.zero)

	open override func onCreateContent() {
		super.onCreateContent()
		titleBar.back()
		contentView.addSubview(webView)
		webView.layout.fill()

	}
}