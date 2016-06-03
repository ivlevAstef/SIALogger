//
//  SIALogColoredConsoleOutput.m
//  SIALogger
//
//  Created by Alexander Ivlev on 03/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogColoredConsoleOutput.h"
#import "SIALogLevels.h"

@interface SIALogColoredConsoleOutput ()

@property (nonatomic, strong) NSMapTable* colorForegroundMap;
@property (nonatomic, strong) NSMapTable* colorBackgroundMap;

@end

@implementation SIALogColoredConsoleOutput

- (instancetype)init {
  self = [super init];
  if (self) {
    self.colorForegroundMap = [NSMapTable strongToStrongObjectsMapTable];
    self.colorBackgroundMap = [NSMapTable strongToStrongObjectsMapTable];
    
    [self setDefaultColors];
    [self enableXcodeColorsPlugin];
  }
  
  return self;
}

- (void)enableXcodeColorsPlugin {
  setenv("XcodeColors", "YES", 0);
}

- (void)logWithTime:(NSString*)time Level:(SIALogLevel*)level File:(NSString*)file Line:(NSNumber*)line Msg:(NSString*)msg {
  assert(nil != time && nil != level && nil != file && nil != line && nil != msg);
  
  NSString* coloredLevel = [self colored:[NSString stringWithFormat:@"[%@]", level.name.uppercaseString] OnLevel:level];
  //for faster
  printf("%s %s {%s:%lld} %s\r\n", [time UTF8String], [coloredLevel UTF8String], [file UTF8String], [line unsignedLongLongValue], [msg UTF8String]);
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
