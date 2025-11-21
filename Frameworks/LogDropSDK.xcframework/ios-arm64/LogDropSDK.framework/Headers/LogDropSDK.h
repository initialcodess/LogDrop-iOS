//
//  LogDropSDK.h
//  LogDropSDK
//
//  Created by Initial Code on 4.12.2024.
//

#import <Foundation/Foundation.h>

//! Project version number for LogDropSDK.
FOUNDATION_EXPORT double LogDropSDKVersionNumber;

// Only import the Swift-generated header when building as Objective-C or another client,
// and only if the header is actually available. This avoids circular/self-include issues
// while the Swift part of the module is still being compiled.
#if !defined(SWIFT) && __has_include(<LogDropSDK/LogDropSDK-Swift.h>)
#import <LogDropSDK/LogDropSDK-Swift.h>
#elif !defined(SWIFT) && __has_include("LogDropSDK-Swift.h")
#import "LogDropSDK-Swift.h"
#endif
