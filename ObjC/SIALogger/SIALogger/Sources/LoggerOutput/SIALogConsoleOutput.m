//
//  SIALogConsoleOutput.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALogConsoleOutput.h"

@interface SIALogConsoleOutput ()

@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, strong) NSFileHandle* output;

@end

@implementation SIALogConsoleOutput

- (instancetype)init {
  self = [super init];

  if (self) {
    self.startDate = [NSDate date];
    self.output = [NSFileHandle fileHandleWithStandardOutput];
  }

  return self;
}

- (void)logLevel:(SIALogLevel*)level AndMessage:(NSString*)message AndEventData:(NSDictionary*)eventInfo {
  if (nil != message) {
    NSString* log = [NSString stringWithFormat:@"%@ %@\r\n", [self currentTime], message];
    [self.output writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
  }
}

- (void)event:(NSString*)name WithData:(NSDictionary*)data {
  if (nil != name) {
    NSString* log = [NSString stringWithFormat:@"%@ Event:%@\r\n", [self currentTime], name];
    [self.output writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
  }
}

- (NSString*)currentTime {
  static dispatch_once_t once;
  static NSDateFormatter* dateFormatter = nil;

  dispatch_once(&once, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
  });

  return [dateFormatter stringFromDate:[NSDate dateWithTimeInterval:0 sinceDate:self.startDate]];
}

@end
