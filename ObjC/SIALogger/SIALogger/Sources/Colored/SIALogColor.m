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

+ (NSMapTable*)colorForegroundMap {
  static dispatch_once_t onceToken;
  static NSMapTable* colorMap = nil;
  dispatch_once(&onceToken, ^{
    colorMap = [NSMapTable strongToStrongObjectsMapTable];
  });
  return colorMap;
}

+ (NSMapTable*)colorBackgroundMap {
  static dispatch_once_t onceToken;
  static NSMapTable* colorMap = nil;
  dispatch_once(&onceToken, ^{
    colorMap = [NSMapTable strongToStrongObjectsMapTable];
  });
  return colorMap;
}

+ (void)setForegroundColor:(SIALogColor*)color OnLevel:(SIALogLevel*)level {
  assert(nil != level);
  
  if (nil == color) {
    [[self colorForegroundMap] removeObjectForKey:level];
  } else {
    [[self colorForegroundMap] setObject:color forKey:level];
  }
}

+ (void)setBackgroundColor:(SIALogColor*)color OnLevel:(SIALogLevel*)level {
  assert(nil != level);
  
  if (nil == color) {
    [[self colorBackgroundMap] removeObjectForKey:level];
  } else {
    [[self colorBackgroundMap] setObject:color forKey:level];
  }
}

#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET XCODE_COLORS_ESCAPE @";"

+ (NSString*)colored:(NSString*)text OnLevel:(SIALogLevel*)level {
  assert(nil != level);
  
  SIALogColor* fgColor = [[self colorForegroundMap] objectForKey:level];
  SIALogColor* bgColor = [[self colorBackgroundMap] objectForKey:level];
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

@implementation SIALogLevel (Colored)

- (void)setForegroundColor:(SIALogColor*)color {
  return [SIALogColor setForegroundColor:color OnLevel:self];
}

- (void)setBackgroundColor:(SIALogColor*)color {
  return [SIALogColor setBackgroundColor:color OnLevel:self];
}

- (NSString*)colored:(NSString*)text {
  return [SIALogColor colored:text OnLevel:self];
}

@end

@implementation SIALogConfig (Colored)

#define SET_FCOLOR(LEVEL,RED,GREEN,BLUE) [LEVEL setForegroundColor:[[SIALogColor alloc] initByRed:(RED) Green:(GREEN) Blue:(BLUE)]]
#define SET_BCOLOR(LEVEL,RED,GREEN,BLUE) [LEVEL setBackgroundColor:[[SIALogColor alloc] initByRed:(RED) Green:(GREEN) Blue:(BLUE)]]

+ (void)enableXcodeColorsPlugin {
  setenv("XcodeColors", "YES", 0);
  
  [self setDefaultColors];
  [self setDefaultColorFormatFunction];
}

+ (void)setDefaultColors {
  SET_FCOLOR([SIALogLevels Fatal], 220, 220, 220);
  SET_BCOLOR([SIALogLevels Fatal], 220, 0, 0);

  SET_FCOLOR([SIALogLevels Error], 220, 0, 0);
  SET_FCOLOR([SIALogLevels Warning], 220, 80, 0);
  SET_FCOLOR([SIALogLevels Info], 80, 80, 220);
  SET_FCOLOR([SIALogLevels Trace], 80, 80, 80);
}

#undef SET_FCOLOR
#undef SET_BCOLOR

+ (void)setDefaultColorFormatFunction {
  [self setFormatFunction:^NSString*(SIALogLevel* level, NSString* file, SIALineNumber line, NSString* msg) {
    return [NSString stringWithFormat:@"%@ {%@:%lld}: %@", [level colored:[NSString stringWithFormat:@"[%@]",level.name.uppercaseString]], file, line, msg];
  }];
}


@end