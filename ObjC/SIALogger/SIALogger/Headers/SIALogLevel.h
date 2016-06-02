//
//  SIALogLevel.h
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIALogLevel : NSObject

@property (nonatomic, readonly) NSUInteger priority;
@property (nonatomic, readonly) NSString* name;

- (id)init __attribute__((unavailable("Used initWithPriority:AndName: instead.")));
- (instancetype)initWithPriority:(NSUInteger)priority AndName:(NSString*)name;

@end
