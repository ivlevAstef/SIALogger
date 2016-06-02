//
//  SIALogLevel.m
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogLevel.h"

@interface SIALogLevel()

@property (nonatomic, assign) NSUInteger priority;
@property (nonatomic, copy) NSString* name;

@end

@implementation SIALogLevel

- (instancetype)initWithPriority:(NSUInteger)priority AndName:(NSString*)name {
  self = [super init];
  if (self) {
    self.priority = priority;
    self.name = name ?: @"";
  }
  
  return self;
}

@end
