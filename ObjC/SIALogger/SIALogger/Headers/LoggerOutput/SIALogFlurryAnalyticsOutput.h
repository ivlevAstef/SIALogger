//
//  SIALogFlurryAnalyticsOutput.h
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#ifdef SIA_LOGGER_FLURRY_ANALYTICS

#import "SIALogOutputProtocol.h"

@interface SIALogFlurryAnalyticsOutput : NSObject <SIALogOutputProtocol>

- (id)init __attribute__((unavailable("Used initWithApiKey: instead.")));
- (instancetype)initWithApiKey:(NSString*)apiKey;

@end

#endif
