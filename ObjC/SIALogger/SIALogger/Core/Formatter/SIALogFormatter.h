//
//  SIALogFormatter.h
//  SIALogger
//
//  Created by Alexander Ivlev on 06/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIALogMessage.h"

@interface SIALogFormatter : NSObject

- (instancetype)initWithFormat:(NSString*)format;
- (id)init __attribute__((unavailable("Used initWithFormat: instead.")));

- (NSString*)toString:(SIALogMessage*)msg;

@end
