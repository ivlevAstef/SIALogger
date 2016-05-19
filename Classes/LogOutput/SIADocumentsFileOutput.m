//
//  SIADocumentsFileOutput.m
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//

#import "SIADocumentsFileOutput.h"

@interface SIADocumentsFileOutput ()

@property (nonatomic, strong) NSFileHandle* output;

@end

@implementation SIADocumentsFileOutput

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
      [SIADocumentsFileOutput pathWithDateAndFileName:fileName] :
      [SIADocumentsFileOutput pathWithFileName:fileName];

    [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    self.output = [NSFileHandle fileHandleForWritingAtPath:filePath];
    
    NSAssert(nil != self.output, @"Can't create file handler for path:%@", filePath);
  }

  return self;
}

- (void)log:(NSString*)logString {
  if (nil != logString) {
    NSString* log = [NSString stringWithFormat:@"%@ %@\n", [self currentTime], logString];
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

  return [dateFormatter stringFromDate:[NSDate date]];
}

@end
