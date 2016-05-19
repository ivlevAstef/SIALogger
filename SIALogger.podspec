Pod::Spec.new do |s|

  s.name         = "SIALogger"
  s.version      = "0.9.0"
  s.summary      = "SIALogger - library for simplify log."

  s.description  = <<-DESC
  					SIALogger - library for simplify log and assertion.
  					Supported five log level: {Fatal, Error, Warning, Info, Trace}
            Fatal level abort program.

  					for setting use: [SIALogger sharedInstance]

  					for log use: SIALog{LEVEL}(MSG, ...) etc. SIALogDebug(@"Debug message");
            also support logIf: SIALogIf{LEVEL}(CONDITION, MSG) etc. SIALogIfWarning(nil == model, @"Model is nil");
            and logRetIf: SIALogRetIf{LEVEL}(CONDITION, RET_VALUE, MSG) etc. SIALogRetIfInfo(nil == model, nil, @"Model is nil");

            for assert use: SIALogAssertMsg(CONDITION, MSG) or SIALogAssert(CONDITION) etc. SIALogAssert(nil != model);

            for contract requires use: 
              SIARequires(CONDITION) 
              SIARequiresType(VALUE, TYPE) etc. SIARequiresType(model, Model)
              SIARequiresProtocol(VALUE, PROTOCOL) etc. SIARequiresProtocol(model, ModelProtocol)
              SIARequiresSelector(VALUE, SELECTOR) etc. SIARequiresSelector(model, @selector(method))
              SIARequiresNotNil(VALUE) etc. SIARequiresNotNil(model)
              SIARequiresArrayInterval(BEGIN, VALUE, END) etc. SIARequiresArrayInterval(0, model.value, 100)

            also have: SIANotImplemented() SIALogCheck(CONDITION)

            DESC

  s.homepage     = "https://github.com/ivlevAstef/SIALogger"
  s.documentation_url = "https://github.com/ivlevAstef/SIALogger"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "Alexander.Ivlev" => "ivlev.stef@gmail.com" }

  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"

  s.source       = { :hg => "https://github.com/ivlevAstef/SIALogger" }

  s.source_files  = "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/*/*.h"

  s.requires_arc = true

end
