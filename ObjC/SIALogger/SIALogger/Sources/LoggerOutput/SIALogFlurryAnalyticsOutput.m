//
//  SIALogFlurryAnalyticsOutput.m
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#ifdef SIA_LOGGER_FLURRY_ANALYTICS

#import "SIALogFlurryAnalyticsOutput.h"
#import "Flurry.h"

@implementation SIALogFlurryAnalyticsOutput

- (instancetype)initWithApiKey:(NSString*)apiKey {
  self = [super init];
  
  if (self) {
    [Flurry startSession:apiKey];
  }
  
  return self;
}

- (void)event:(NSString*)name WithData:(NSDictionary*)data {
  if (nil == name) {
    return;
  }
  
  if (nil == data) {
    [Flurry logEvent:name];
  } else {
    if ([[data objectForKey:@"timed"] boolValue]) {
      [Flurry logEvent:name withParameters:data timed:YES];
    } else {
      [Flurry logEvent:name withParameters:data];
    }
  }
}

@end

#endif
