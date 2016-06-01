Pod::Spec.new do |s|

  s.name         = 'SIALogger'
  s.version      = '1.0.0'
  s.summary      = 'SIALogger - library for simplify log.'

  s.description  = <<-DESC
  					SIALogger - library for simplify log and assertion, for Objective-C (If you want to use SIALogger from Swift, see the 'SIALogger”'' pod.)
            Supported five log level: {Fatal, Error, Warning, Info, Trace}
            For more information see: https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Objective-C

            DESC

  s.homepage     = 'https://github.com/ivlevAstef/SIALogger'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.documentation_url = 'https://github.com/ivlevAstef/SIALogger/wiki/SIALogger-Objective-C'

  s.author       = { 'Alexander.Ivlev' => 'ivlev.stef@gmail.com' }
  s.source       = { :git => 'https://github.com/ivlevAstef/SIALogger.git', :tag => "v#{s.version}" }
  s.requires_arc = true

  s.ios.deployment_target = '5.0'

  s.source_files  = 'ObjC/SIALogger/SIALogger/**/*.{h,m}'
  s.public_header_files = 'ObjC/SIALogger/SIALogger/Headers/**/*.h'

end
