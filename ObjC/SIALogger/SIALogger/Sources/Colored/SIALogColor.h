//
//  SIALogColor.h
//  SIALogger
//
//  Created by Alexander Ivlev on 02/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "SIALogLevels.h"
#import "SIALogConfig.h"

typedef unsigned char ColorComponent;

@interface SIALogColor : NSObject

- (instancetype)initByRed:(ColorComponent)red Green:(ColorComponent)green Blue:(ColorComponent)blue;

@end

@interface SIALogLevel (Colored)

- (void)setForegroundColor:(SIALogColor*)color;
- (void)setBackgroundColor:(SIALogColor*)color;

- (NSString*)colored:(NSString*)text;

@end

@interface SIALogConfig (Colored)

+ (void)enableXcodeColorsPlugin;
+ (void)setDefaultColors;
+ (void)setDefaultColorFormatFunction;

@end