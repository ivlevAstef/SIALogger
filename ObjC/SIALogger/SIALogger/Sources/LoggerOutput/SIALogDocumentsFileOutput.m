//
//  SIALogDocumentsFileOutput.m
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#import "SIALogDocumentsFileOutput.h"

@interface SIALogDocumentsFileOutput ()

@property (nonatomic, strong) NSFileHandle* output;

@end

@implementation SIALogDocumentsFileOutput

+ (NSString*)documentsDirectory {
  NSArray<NSString*>* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSAssert(paths.count > 0, @"Can't search path for documetn directory.");
  
  return [paths objectAtIndex:0];
}

+ (NSString*)pathWithFileName:(NSString*)fileName {
  return [NSString stringWithFormat:@"%@/%@.log", [self documentsDirectory], fileName];
}

+ (NSString*)pathWithDateAndFileName:(NSString*)fileName {
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
  [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];

  NSString* dateString = [dateFormatter stringFromDate:[NSDate date]];

  return [NSString stringWithFormat:@"%@/%@_%@.log", [self documentsDirectory], fileName, dateString];
}

- (instancetype)initWithFileName:(NSString*)fileName joinDate:(BOOL)join {
  self = [super init];
  if (self) {
    NSString* filePath = join ?
      [SIALogDocumentsFileOutput pathWithDateAndFileName:fileName] :
      [SIALogDocumentsFileOutput pathWithFileName:fileName];

    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    self.output = [NSFileHandle fileHandleForWritingAtPath:filePath];
    
    NSAssert(nil != self.output, @"Can't create file handler for path:%@", filePath);
  }

  return self;
}

- (void)logWithTime:(NSString*)time Level:(SIALogLevel*)level File:(NSString*)file Line:(NSNumber*)line Msg:(NSString*)msg {
  assert(nil != time && nil != level && nil != file && nil != line && nil != msg);
  
  NSString* log = [NSString stringWithFormat:@"%@ [%@] {%@:%@}: %@\r\n", time, level.name.uppercaseString, file, line, msg];
  [self.output writeData:[log dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
