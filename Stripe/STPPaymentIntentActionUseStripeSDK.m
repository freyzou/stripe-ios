//
//  STPPaymentIntentActionUseStripeSDK.m
//  StripeiOS
//
//  Created by Cameron Sabol on 5/15/19.
//  Copyright © 2019 Stripe, Inc. All rights reserved.
//

#import "STPPaymentIntentActionUseStripeSDK.h"

#import "NSDictionary+Stripe.h"

NS_ASSUME_NONNULL_BEGIN

@implementation STPPaymentIntentActionUseStripeSDK

@synthesize allResponseFields = _allResponseFields;

+ (nullable instancetype)decodedObjectFromAPIResponse:(nullable NSDictionary *)response {
    NSDictionary *dict = [response stp_dictionaryByRemovingNulls];
    if (!dict) {
        return nil;
    }

    STPPaymentIntentActionUseStripeSDKType type = STPPaymentIntentActionUseStripeSDKTypeUnknown;
    NSString *typeString = [dict stp_stringForKey:@"type"];
    if ([typeString isEqualToString:@"stripe_3ds2_fingerprint"]) {
        type = STPPaymentIntentActionUseStripeSDKType3DS2Fingerprint;
    }

    if (type == STPPaymentIntentActionUseStripeSDKTypeUnknown) {
        return nil;
    }

    NSString *directoryServer = [dict stp_stringForKey:@"directory_server_name"];
    if (directoryServer == nil || directoryServer.length == 0) {
        return nil;
    }


    STPPaymentIntentActionUseStripeSDK *action = [[self alloc] init];
    action->_type = type;
    action->_directoryServer = [directoryServer copy];
    action->_serverTransactionID = [[dict stp_stringForKey:@"server_transaction_id"] copy];
    action->_threeDS2SourceID = [[dict stp_stringForKey:@"three_d_secure_2_source"] copy];
    action->_allResponseFields = dict;
    return action;
}

@end

NS_ASSUME_NONNULL_END