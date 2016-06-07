//
//  SIALogMessage.m
//  SIALogger
//
//  Created by Alexander Ivlev on 06/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogMessage.h"

@interface SIALogMessage ()

@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) SIALogLevel* level;
@property (nonatomic, strong) NSString* file;
@property (nonatomic, strong) NSNumber* line;
@property (nonatomic, strong) NSString* text;

@end

@implementation SIALogMessage

- (instancetype)initWithTime:(NSString*)time Level:(SIALogLevel*)level File:(NSString*)file Line:(NSNumber*)line Text:(NSString*)text {
  assert(nil != time && nil != level && nil != file && nil != line && nil != text);
  
  self = [super init];
  if (self) {
    self.time = time;
    self.level = level;
    self.file = file;
    self.line = line;
    self.text = text;
  }
  
  return self;
}

@end
