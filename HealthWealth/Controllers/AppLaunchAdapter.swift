//
//  AppLaunchAdapter.swift
//  HealthWealth
//
//  Created by Vittal Pai on 1/24/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import Foundation
import IBMAppLaunch

internal class AppLaunchAdapter {
    
    internal static var sharedInstance = AppLaunchAdapter()
    
    internal func initialize(username: String, userType: String, completionHandler: @escaping AppLaunchCompletionHandler) {
        let config = AppLaunchConfig.Builder().fetchPolicy(.REFRESH_ON_EVERY_START).cacheExpiration(1).eventFlushInterval(100).build()
        let user = AppLaunchUser.Builder(userId: username).custom(key: "type", value: userType).build()
        AppLaunch.sharedInstance.initialize(region: .US_SOUTH, appId: "1e22e2af-4b02-47a8-b2f0-863fbc833da1", clientSecret: "f9c6a74f-c0f3-4ab6-b1d2-bfa004aa07a9", config: config, user: user, completionHandler: completionHandler)
    }
    
    internal func isOnlineEyeTestMenuEnabled() -> Bool {
        do {
            return try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_a2nqtg2g6")
        } catch {
            return false
        }
    }
    
    internal func getOnlineEyeTestMenuTitle() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_a2nqtg2g6", propertyCode: "_lpvaa580p")
        } catch {
            return "Online Eye Clinic"
        }
    }
    
    internal func getOnlineEyeTestMenuHeader() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_a2nqtg2g6", propertyCode: "_l84ebkywk")
        } catch {
            return "Examine my Eye"
        }
    }
    
    internal func getOnlineEyeTestButtonTitle() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_a2nqtg2g6", propertyCode: "_e92o5okpy")
        } catch {
            return "Capture"
        }
    }
    
    internal func sendOnlineEyeTestMetric() {
        AppLaunchAdapter.sharedInstance.sendMetrics(value: "_811rru335")
    }
    
    internal func isSubmissionMenuEnabled() -> Bool {
        do {
            return try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_7d6pkh1fi")
        } catch {
            return false
        }
    }
    
    internal func getSubmissionMenuTitle() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_7d6pkh1fi", propertyCode: "_2z9rib38b")
        } catch {
            return "Submission"
        }
    }
    
    internal func sendSubmissionMenuPostiveMetric() {
        AppLaunchAdapter.sharedInstance.sendMetrics(value: "_95d3kddtl")
    }
    
    internal func sendSubmissionMenuNegativeMetric() {
        AppLaunchAdapter.sharedInstance.sendMetrics(value: "_4ks4z3u32")
    }
    
    internal func isPrescriptionMenuEnabled() -> Bool {
        do {
            return try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_obm2z42ym")
        } catch {
            return false
        }
    }
    
    internal func getPrescriptionMenuTitle() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_obm2z42ym", propertyCode: "_r2kbuapvd")
        } catch {
            return "Prescription"
        }
    }
    
    internal func getPrescriptionMenuType() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_obm2z42ym", propertyCode: "_d7u9so40i")
        } catch {
            return "normalView"
        }
    }
    
    internal func sendPrescriptionMenuMetric() {
        AppLaunchAdapter.sharedInstance.sendMetrics(value: "_v3vux5y67")
    }
    
    internal func isBackgroundColorChanged() -> Bool {
        do {
            return try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_13tnalkik")
        } catch {
            return false
        }
    }
    
    internal func getBackGroundColor() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_13tnalkik", propertyCode: "_04rqh3vzs")
        } catch {
            return "#FEC058"
        }
    }
    
    internal func displayMessage() {
        do {
            try AppLaunch.sharedInstance.displayMessage()
        } catch {
            
        }
    }
    
    internal func sendMetrics(value: String) {
        do {
            try AppLaunch.sharedInstance.sendMetrics(codes: [value])
        } catch {
            
        }
    }
    
    internal func destroy() {
        AppLaunch.sharedInstance.destroy { (Success, Failure) in
            if(Success != nil) {
                print("Successfully unregistered from AppLaunch Service")
            }
        }
    }
}
