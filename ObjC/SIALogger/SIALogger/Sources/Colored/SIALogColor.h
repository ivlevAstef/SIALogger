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
- (id)init __attribute__((unavailable("Used initByRed:Green:Blue: instead.")));

@property (nonatomic, readonly) NSString* xcodeColor;

@end