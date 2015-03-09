Pod::Spec.new do |s|
  s.name             = "EAResistantScrollView"
  s.version          = "0.2.0"
  s.summary          = "A custom UIScrollView with a customizable overscroll resistance."
  s.description      = <<-DESC
A subclass of UIScrollView that allows to perform tweaks on how much overscroll the users can perform.
DESC
  s.homepage         = "https://github.com/Eddpt/EAResistantScrollView"
  s.license          = 'MIT'
  s.author           = { "Edgar Antunes" => "Eddpt@users.noreply.github.com" }
  s.source           = { :git => "https://github.com/Eddpt/EAResistantScrollView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
