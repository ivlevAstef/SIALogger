//
//  SIALogConsoleOutput.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALogConsoleOutput.h"
#import "SIALogFormatter.h"

@interface SIALogConsoleOutput ()

@property (nonatomic, strong) SIALogFormatter* formatter;

@end

@implementation SIALogConsoleOutput

static NSString* defaultLogFormat = @"%t [%U] {%f:%l}: %m";

- (instancetype)init {
  return [self initWithFormat:defaultLogFormat];
}

- (instancetype)initWithFormat:(NSString*)format {
  assert(nil != format);
  self = [super init];
  
  if (self) {
    self.formatter = [[SIALogFormatter alloc] initWithFormat:format];
  }
  
  return self;
}

- (void)log:(SIALogMessage*)msg {
  printf("%s\r\n", [[self.formatter toString:msg] UTF8String]);
}

@end
