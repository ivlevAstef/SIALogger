//
//  SIAILoggerOutput.h
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//

#import <Foundation/Foundation.h>

@protocol SIAILoggerOutput <NSObject>

- (void)log:(NSString*)logString;

@end
