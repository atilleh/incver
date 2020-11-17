# Incver is the main module.
require "yaml"
require "option_parser"
require "./exceptions"

module Incver
  VERSION = "1.0.0"

  class App
    @stdin : String

    def initialize()
      @options = Hash(String, Bool).new
      @options["major"] = false
      @options["minor"] = false
      @options["patch"] = false

      @stdin = STDIN.gets.not_nil!.to_s

      OptionParser.parse do |parser|
        parser.banner = "Increment SEMVER from STDIN."
        parser.on("+major", "Increment major") { @options["major"] = true }
        parser.on("+minor", "Increment minor") { @options["minor"] = true }
        parser.on("+patch", "Increment patch") { @options["patch"] = true }
        parser.on("-h", "--help", "Show this help") do
          puts parser
          exit
        end
      end
    end

    # validates the content is SEMVER compliant.
    # raise an error if no match found.
    # returns the Regex::MatchData.
    def validate_version
      version = /^([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+[0-9A-Za-z-]+)?$/i.match(@stdin)
      raise IncverSyntaxException.new(@stdin) if version.nil?

      version
    end

    # increment the selected version field.
    # writes the result in STDOUT.
    def increment(version : Regex::MatchData)
      full, major, minor, patch = version
      major = major.to_i
      minor = minor.to_i
      patch = patch.to_i
      
      major += 1 if @options["major"]
      minor += 1 if @options["minor"]
      patch += 1 if @options["patch"]
      puts "#{major}.#{minor}.#{patch}"
      
      exit(0)
    end
  end
end

app = Incver::App.new
version = app.validate_version
app.increment(version)