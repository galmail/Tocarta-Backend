# module SubtleData
  class Subtledata::Ticket

    def initialize(client)
      @client = client
    end

    def dine_in()
      
      
    end





    def errors
      {
        "0" => "General failure. Try again.",
        "-1" => "Username not long enough",
        "-2" => "Password not long enough",
        "-3" => "First name not passed",
        "-5" => "Last name not passed",
        "-6" => "Date of birth not passed",
        "-8" => "Bad email address",
        "-11" => "Unique identifier not passed",
        "-100" => "Not using HTTPS",
        "-101" => "Username already exists"
      }
    end
  end
# end