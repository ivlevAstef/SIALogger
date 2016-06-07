//
//  SIALogColor.m
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogColor.h"
#import "SIALogConfig.h"

@interface SIALogColor ()

@property (nonatomic, strong) NSString* xcodeColor;

@end

@implementation SIALogColor

- (instancetype)initByRed:(ColorComponent)red Green:(ColorComponent)green Blue:(ColorComponent)blue {
  self = [super init];
  
  if (self) {
    self.xcodeColor = [SIALogColor colorStrByRed:red Green:green Blue:blue];
  }
  
  return self;
}

+ (NSString*)colorStrByRed:(ColorComponent)red Green:(ColorComponent)green Blue:(ColorComponent)blue {
  return [NSString stringWithFormat:@"%d,%d,%d;", (unsigned int)red,(unsigned int)green,(unsigned int)blue];
}

@end