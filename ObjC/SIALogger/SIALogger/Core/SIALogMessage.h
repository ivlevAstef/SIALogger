//
//  SIALogMessage.h
//  SIALogger
//
//  Created by Alexander Ivlev on 06/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogLevel.h"

@interface SIALogMessage : NSObject

@property (nonatomic, readonly) NSString* time;
@property (nonatomic, readonly) SIALogLevel* level;
@property (nonatomic, readonly) NSString* file;
@property (nonatomic, readonly) NSNumber* line;
@property (nonatomic, readonly) NSString* text;

- (instancetype)initWithTime:(NSString*)time Level:(SIALogLevel*)level File:(NSString*)file Line:(NSNumber*)line Text:(NSString*)text;
- (id)init __attribute__((unavailable("Used initWithTime:Level:File:Line:Text: instead.")));

@end
