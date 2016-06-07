//
//  SIALogColoredConsoleOutput.m
//  SIALogger
//
//  Created by Alexander Ivlev on 03/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogColoredConsoleOutput.h"
#import "SIALogLevels.h"
#import "SIALogColoredFormatter.h"

@interface SIALogColoredConsoleOutput ()

@property (nonatomic, strong) NSMapTable* colorForegroundMap;
@property (nonatomic, strong) NSMapTable* colorBackgroundMap;

@property (nonatomic, strong) SIALogColoredFormatter* formatter;

@end

@implementation SIALogColoredConsoleOutput

static NSString* defaultLogFormat = @"%t %c[%3]%c {%f:%l}: %m";

- (instancetype)init {
  return [self initWithFormat:defaultLogFormat];
}

- (instancetype)initWithFormat:(NSString*)format {
  self = [super init];
  if (self) {
    self.colorForegroundMap = [NSMapTable strongToStrongObjectsMapTable];
    self.colorBackgroundMap = [NSMapTable strongToStrongObjectsMapTable];
    
    [self setDefaultColors];
    [self enableXcodeColorsPlugin];
    
    self.formatter = [[SIALogColoredFormatter alloc] initWithFormat:format];
  }
  
  return self;
}

- (void)enableXcodeColorsPlugin {
  setenv("XcodeColors", "YES", 0);
}

- (void)log:(SIALogMessage*)msg {
  NSString* logMsg = [self.formatter toString:msg WithColoredMethod:^NSString*(NSString* string) {
    return [self colored:string OnLevel:msg.level];
  }];
  
  printf("%s\r\n", [logMsg UTF8String]);
}

- (void)setForegroundColor:(SIALogColor*)color OnLevel:(SIALogLevel*)level {
  assert(nil != level);
  
  if (nil == color) {
    [self.colorForegroundMap removeObjectForKey:level];
  } else {
    [self.colorForegroundMap setObject:color forKey:level];
  }
}

- (void)setBackgroundColor:(SIALogColor*)color OnLevel:(SIALogLevel*)level {
  assert(nil != level);
  
  if (nil == color) {
    [self.colorBackgroundMap removeObjectForKey:level];
  } else {
    [self.colorBackgroundMap setObject:color forKey:level];
  }
}

#define SET_FCOLOR(LEVEL,RED,GREEN,BLUE) [self setForegroundColor:[[SIALogColor alloc] initByRed:(RED) Green:(GREEN) Blue:(BLUE)] OnLevel:LEVEL]
#define SET_BCOLOR(LEVEL,RED,GREEN,BLUE) [self setBackgroundColor:[[SIALogColor alloc] initByRed:(RED) Green:(GREEN) Blue:(BLUE)] OnLevel:LEVEL]

- (void)setDefaultColors {
  SET_FCOLOR([SIALogLevels Fatal], 255, 255, 255);
  SET_BCOLOR([SIALogLevels Fatal], 255, 0, 0);
  
  SET_FCOLOR([SIALogLevels Error], 255, 0, 0);
  SET_FCOLOR([SIALogLevels Warning], 255, 128, 0);
  SET_FCOLOR([SIALogLevels Info], 64, 64, 255);
  SET_FCOLOR([SIALogLevels Trace], 128, 128, 128);
}

#undef SET_FCOLOR
#undef SET_BCOLOR

#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET XCODE_COLORS_ESCAPE @";"

- (NSString*)colored:(NSString*)text OnLevel:(SIALogLevel*)level {
  assert(nil != level);
  
  SIALogColor* fgColor = [self.colorForegroundMap objectForKey:level];
  SIALogColor* bgColor = [self.colorBackgroundMap objectForKey:level];
  if (nil == fgColor && nil == bgColor) {
    return text;
  }
  
  NSString* fgColorStr = (nil != fgColor) ? [XCODE_COLORS_ESCAPE@"fg" stringByAppendingString:fgColor.xcodeColor] : @"";
  NSString* bgColorStr = (nil != bgColor) ? [XCODE_COLORS_ESCAPE@"bg" stringByAppendingString:bgColor.xcodeColor] : @"";
  
  return [NSString stringWithFormat:@"%@%@%@"XCODE_COLORS_RESET, bgColorStr, fgColorStr, text];
}

#undef XCODE_COLORS_ESCAPE
#undef XCODE_COLORS_RESET

@end
