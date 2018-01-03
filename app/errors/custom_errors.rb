module CustomErrors
  # Authentication errors
  class UserNotFound < StandardError; end
  class Unauthenticated < StandardError; end

  # Access errors
  class Unauthorized < StandardError; end

  # Contract errors
  class ContractInactive < StandardError; end
end
