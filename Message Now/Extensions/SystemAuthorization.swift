//
//  SystemAuthorization.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/12/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Photos
import CoreLocation

struct SystemAuthorization {
    
    static let shared = SystemAuthorization()
    
    func photoAuthorization(complation: @escaping(Bool, String?)->()) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
            case .authorized:
                complation(true, nil)
            case .denied, .notDetermined, .restricted:
                PHPhotoLibrary.requestAuthorization { (isAuth) in
                    if isAuth == .authorized {
                        complation(true, nil)
                    } else {
                        complation(false, "Apr SDK Error: Please go to Settings>SmallTalk>Photos>Choose Read and Write to able access photos")
                    }
            }
            default:
                complation(false, "Apr SDK Error: Please go to Settings>SmallTalk>Photos>Choose Read and Write to able access photos")
        }
    }
    
    func cameraAuthorization(complation: @escaping(Bool, String?)->()) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
            case .authorized:
                complation(true, nil)
            case .denied, .notDetermined, .restricted:
                AVCaptureDevice.requestAccess(for: .video) { (isAuth) in
                    if isAuth {
                        complation(true, nil)
                    } else {
                        complation(false, "Apr SDK Error: Please go to Settings>SmallTalk>Camera>Press On to able access camera")
                    }
            }
            default:
                complation(false, "Apr SDK Error: Please go to Settings>SmallTalk>Camera>Press On to able access camera")
        }
    }
    
    func locationAuthorization(complation: @escaping(Bool, String?)->()) {
        let locStatus = CLLocationManager.authorizationStatus()
        switch locStatus {
            case .notDetermined, .denied, .restricted:
                complation(false, nil)
            case .authorizedAlways, .authorizedWhenInUse:
                complation(true, nil)
            default:
                complation(false, "Apr SDK Error: Please enable Location Services in your Settings")
        }
    }
    
    func recordAuthorization(complation: @escaping(Bool, String?)->()) {
        let recordingSession = AVAudioSession.sharedInstance()
        recordingSession.requestRecordPermission() { (isAuth) in
            return isAuth ? complation(true, nil) : complation(false, "Apr SDK Error: Please enable Microphone in your Settings")
        }
    }
}
