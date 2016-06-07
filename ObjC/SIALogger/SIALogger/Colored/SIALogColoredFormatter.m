//
//  SIALogColoredFormatter.m
//  SIALogger
//
//  Created by Alexander Ivlev on 06/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogColoredFormatter.h"
#import "SIALogFormatter.h"

@interface SIALogColoredFormatter ()

@property (nonatomic, strong) NSArray* formatters;

@end

@implementation SIALogColoredFormatter

- (instancetype)initWithFormat:(NSString*)format {
  assert(nil != format);
  self = [super init];
  if (self) {
    self.formatters = [SIALogColoredFormatter parse:format];
  }
  
  return self;
}

- (NSString*)toString:(SIALogMessage*)msg WithColoredMethod:(SIALogColoredMethod)colored {
  NSMutableString* result = [NSMutableString string];
  
  size_t index = 0;
  for (SIALogFormatter* formatter in self.formatters) {
    if (0 == index%2) {
      [result appendString:[formatter toString:msg]];
    } else {
      [result appendString:colored([formatter toString:msg])];
    }
    index++;
  }
  
  return [result copy];
}

+ (NSArray*)parse:(NSString*)format {
  NSMutableArray* result = [NSMutableArray array];
  
  NSString* formatIter = [format copy];
  
  do {
    NSRange range = [formatIter rangeOfString:@"%c"];
    if (NSNotFound != range.location) {
      id formatter = [[SIALogFormatter alloc] initWithFormat:[formatIter substringToIndex:range.location]];
      [result addObject:formatter];
      
      formatIter = [formatIter substringFromIndex:range.location+range.length];
      continue;
    }
    
    if (0 < formatIter.length) {
      [result addObject:[[SIALogFormatter alloc] initWithFormat:formatIter]];
      break;
    }
    
  } while(true);
  
  return [result copy];
}

@end
