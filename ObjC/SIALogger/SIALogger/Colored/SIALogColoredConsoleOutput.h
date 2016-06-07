//
//  SIALogColoredConsoleOutput.h
//  SIALogger
//
//  Created by Alexander Ivlev on 03/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIALogOutputProtocol.h"
#import "SIALogColor.h"

@interface SIALogColoredConsoleOutput : NSObject <SIALogOutputProtocol>

- (instancetype)init;
- (instancetype)initWithFormat:(NSString*)format;

- (void)setForegroundColor:(SIALogColor*)color OnLevel:(SIALogLevel*)level;
- (void)setBackgroundColor:(SIALogColor*)color OnLevel:(SIALogLevel*)level;
- (void)setDefaultColors;

- (NSString*)colored:(NSString*)text OnLevel:(SIALogLevel*)level;

@end
