//
//  VideoSession.swift
//  OpenVideoCall
//
//  Created by GongYuhua on 3/28/16.
//  Copyright © 2016 Agora. All rights reserved.
//

import Cocoa

class VideoSession: NSObject {
    var uid: UInt = 0
    var hostingView: VideoView!
    var canvas: AgoraRtcVideoCanvas!
    var size: CGSize?
    var mediaInfo = MediaInfo() {
        didSet {
            hostingView?.updateInfo(mediaInfo)
        }
    }
    var isVideoMuted = false {
        didSet {
            hostingView.isVideoMuted = isVideoMuted
        }
    }
    
    var shouldShowInfos = false {
        didSet {
            hostingView.shouldShowInfos = shouldShowInfos
            hostingView.updateInfo(mediaInfo)
        }
    }
    
    init(uid: UInt) {
        self.uid = uid
        
        hostingView = VideoView(frame: CGRectMake(0, 0, 100, 100))
        canvas = AgoraRtcVideoCanvas()
        canvas.uid = uid
        canvas.view = hostingView.videoView
        canvas.renderMode = .Render_Fit
    }
}

extension VideoSession {
    static func localSession() -> VideoSession {
        return VideoSession(uid: 0)
    }
    
    func updateMediaInfo(resolution resolution: CGSize? = nil, bitRate: Int? = nil, fps: Int? = nil) {
        if let resolution = resolution {
            mediaInfo.resolution = resolution
        }
        
        if let bitRate = bitRate {
            mediaInfo.bitRate = bitRate
        }
        
        if let fps = fps {
            mediaInfo.fps = fps
        }
        
        if shouldShowInfos {
            hostingView.updateInfo(mediaInfo)
        }
    }
}
