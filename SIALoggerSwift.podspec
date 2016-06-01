Pod::Spec.new do |s|

  s.name         = 'SIALoggerSwift'
  s.version      = '1.0.0'
  s.summary      = 'SIALogger - library for simplify log.'

  s.description  = <<-DESC
  					SIALogger - library for simplify log and assertion, for Swift (If you want to use SIALogger from Objective-C, see the “SIALogger” pod.)
  					Supported five log level: {Fatal, Error, Warning, Info, Trace}
            For more information see: https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Swift

            DESC

  s.homepage     = 'https://github.com/ivlevAstef/SIALogger'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.documentation_url = 'https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Swift'

  s.author       = { 'Alexander.Ivlev' => 'ivlev.stef@gmail.com' }
  s.source       = { :git => 'https://github.com/ivlevAstef/SIALogger.git', :tag => "v#{s.version}" }
  s.requires_arc = true

  s.ios.deployment_target = '8.0'

  s.source_files  = 'Swift/SIALogger/SIALogger/**/*.swift'

  s.requires_arc = true

end
