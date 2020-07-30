//
//  Biometrics.h
//  TABTestKit
//
//  Created by Kane Cheshire on 31/10/2018.
//  Copyright © 2018 Kin + Carta. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Biometrics : NSObject

/*!
 * Enroll biometrics on the simulator
 */
+ (void)enrolled;

/*!
 * Unenroll biometrics on the simulator
 */
+ (void)unenrolled;

/*!
 * Performs a successful biometric authentication on the simulator
 */
+ (void)successfulAuthentication;

/*!
 * Performs an unsuccessful biometric authentication on the simulator
 */
+ (void)unsuccessfulAuthentication;

@end

NS_ASSUME_NONNULL_END
