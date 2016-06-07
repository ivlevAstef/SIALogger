//
//  SIALogFormatter.m
//  SIALogger
//
//  Created by Alexander Ivlev on 06/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogFormatter.h"

typedef NSString* (^MessageToString)(SIALogMessage* message);

@interface SIALogFormatter ()

@property (nonatomic, strong) NSArray* messageToStringArray;

@end

@implementation SIALogFormatter

- (instancetype)initWithFormat:(NSString*)format {
  assert(nil != format);
  self = [super init];
  if (self) {
    self.messageToStringArray = [SIALogFormatter parse:format];
  }
  
  return self;
}

- (NSString*)toString:(SIALogMessage*)msg {
  NSMutableString* result = [NSMutableString string];
  
  for (MessageToString method in self.messageToStringArray) {
    [result appendString:method(msg)];
  }
  
  return [result copy];
}

+ (NSArray*)parse:(NSString*)format {
  NSMutableArray* result = [NSMutableArray array];
  
  NSMutableString* substring = [NSMutableString string];
  for(size_t index = 0; index < format.length; index++) {
    unichar character = [format characterAtIndex:index];
    
    if ('%' == character) {
      NSString* token = [format substringWithRange:NSMakeRange(index, MIN(2, format.length - index))];
      MessageToString method = [self methodByToken:token];
      
      if (nil != method) {
        [self appendSubstringIfNeed:substring To:result];
        [result addObject:method];
        
        index++;//skip next character
        continue;
      }
    }
    
    [substring appendFormat:@"%c", character];
  }
  
  [self appendSubstringIfNeed:substring To:result];
  
  return [result copy];
}

+ (void)appendSubstringIfNeed:(NSMutableString*)substring To:(NSMutableArray*)array {
  if (0 < substring.length) {
    NSString* str = [substring copy];
    
    [array addObject:^NSString*(SIALogMessage* msg){ return str;}];
    [substring setString:@""];
  }
}

+ (MessageToString)methodByToken:(NSString*)token {
  static NSDictionary* tokenToMethod = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    tokenToMethod = @{
                      @"%t" : ^NSString*(SIALogMessage* msg){ return msg.time;},
                      @"%L" : ^NSString*(SIALogMessage* msg){ return msg.level.name;},
                      @"%3" : ^NSString*(SIALogMessage* msg){ return msg.level.shortName;},
                      @"%U" : ^NSString*(SIALogMessage* msg){ return msg.level.name.uppercaseString;},
                      @"%f" : ^NSString*(SIALogMessage* msg){ return msg.file;},
                      @"%l" : ^NSString*(SIALogMessage* msg){ return [msg.line stringValue];},
                      @"%m" : ^NSString*(SIALogMessage* msg){ return msg.text;},
                      };
  });
  
  return [tokenToMethod objectForKey:token];
}

@end
