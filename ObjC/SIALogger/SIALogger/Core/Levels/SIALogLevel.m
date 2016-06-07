//
//  SIALogLevel.m
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogLevel.h"

#define SHORT_NAME_MAX_LENGTH 3

@interface SIALogLevel()

@property (nonatomic, assign) NSUInteger priority;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* shortName;

@end

@implementation SIALogLevel

- (instancetype)initWithPriority:(NSUInteger)priority Name:(NSString*)name ShortName:(NSString*)shortName {
  self = [super init];
  if (self) {
    self.priority = priority;
    self.name = name ?: @"";
    self.shortName = shortName ?: @"";
    
    if (self.shortName.length > SHORT_NAME_MAX_LENGTH) {
      self.shortName = [self.shortName substringToIndex:SHORT_NAME_MAX_LENGTH];
    }
  }
  
  return self;
}

@end
