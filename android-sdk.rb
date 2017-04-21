cask 'android-sdk' do
  version '22.2.1'
  sha256 '2045ddb3a5af12754cf0f6a7a407972add0949fedb204b512be268f405bb50c0'

  # google.com/android/repository/tools_r was verified as official when first introduced to the cask
  url "https://dl.google.com/android/repository/tools_r#{version}-macosx.zip"
  name 'android-sdk'
  homepage 'https://developer.android.com/index.html'

  conflicts_with cask: 'android-platform-tools'

  build_tools_version = '22.2.1'

  %w[android ddms dmtracedump draw9patch etc1tool emulator
     emulator-arm emulator-x86 hierarchyviewer hprof-conv lint mksdcard
     monitor monkeyrunner traceview zipalign].each do |tool|
     binary "#{staged_path}/tools/#{tool}"
  end

  #preflight do
  #  system_command "#{staged_path}/tools/bin/sdkmanager", args: ['tools', 'platform-tools', "build-tools;#{build_tools_version}"], input: 'y'
  #end

  postflight do
    FileUtils.ln_sf(staged_path.to_s, "#{HOMEBREW_PREFIX}/share/android-sdk")
  end

  uninstall_postflight do
    FileUtils.rm("#{HOMEBREW_PREFIX}/share/android-sdk")
  end

  caveats <<-EOS.undent
    We will install android-sdk-tools, platform-tools, and build-tools for you.
    You can control android sdk packages via the sdkmanager command.
    You may want to add to your profile:
      'export ANDROID_HOME=#{HOMEBREW_PREFIX}/share/android-sdk'

    This operation may take up to 10 minutes depending on your internet connection.
    Please, be patient.
  EOS
end
