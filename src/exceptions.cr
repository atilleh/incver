class IncverSyntaxException < Exception
  @composed : String

  def initialize(stdin = "-")
    @composed = "Not a SEMVER syntax : #{stdin}"
    super(@composed)
  end
end

class IncverNoStdinException < Exception
  def initialize(message = "STDIN must be equal of greater than 1.")
    super(message)
  end
end