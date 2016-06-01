//
//  SIALogContracts.h
//  SIALogger
//
//  Created by Ivlev  Alexander (Stef) on 4/15/15.
//  Copyright (c) 2016 Ivlev Alexander. All rights reserved.
//

#ifndef __SIA_LOG_CONTRACTS_H__
#define __SIA_LOG_CONTRACTS_H__

#define SIARequires(CONDITION)                           \
  if(!(CONDITION)) {                                     \
    SIALogFatal(@"Interruption requires: " @#CONDITION); \
  }

#define SIARequiresType(VALUE, TYPE) SIARequires(nil != VALUE && [VALUE isKindOfClass:[TYPE class]])
#define SIARequiresProtocol(VALUE, PROTOCOL) SIARequires(nil != VALUE && [VALUE conformsToProtocol:@protocol(PROTOCOL)])
#define SIARequiresSelector(VALUE, SELECTOR) SIARequires(nil != VALUE && nil != SELECTOR && [VALUE respondsToSelector:SELECTOR])
#define SIARequiresNotNil(VALUE) SIARequires(nil != VALUE)
#define SIARequiresArrayInterval(BEGIN, VALUE, END) SIARequires(BEGIN <= VALUE && VALUE < END)

#endif /* __SIA_LOG_CONTRACTS_H__ */
