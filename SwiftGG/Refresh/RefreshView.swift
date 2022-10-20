//
//  RefreshView.swift
//  SwiftGG
//
//  Created by stoicer on 2021/1/5.
//

import Foundation

class RefreshView: MJRefreshAutoGifFooter {
    override func prepare() {
        super.prepare()
        mj_h = 50
        var images = [UIImage]()
        for index in 1..<9 {
            let image = UIImage(named: "image_\(index)")
            images.append(image!)
        }
        
        setImages(images, for: .idle)
        setImages(images, for: .pulling)
        setImages(images, for: .refreshing)
        setTitle("下拉以刷新", for: .idle)
        setTitle("正在下拉", for: .pulling)
        setTitle("正在刷新", for: .refreshing)
        setTitle("没有更多数据", for: .noMoreData)
        
    }
    
    //    override func placeSubviews() {
    //        super.placeSubviews()
    //        gifView?.mj_x = 135
    //        gifView?.center.y = (stateLabel?.center.y)!
    //    }
}

