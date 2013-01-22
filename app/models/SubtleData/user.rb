module SubtleData
  class User

    def initialize(client)
      @client = client
    end

    def create(username, password, email, options = {})
      response = @client.get "0110", [
        username,
        password,
        options[:first_name] || username,
        options[:middle_name],
        options[:last_name] || "Last Name",
        options[:dob],
        options[:cell_phone],
        email,
        options[:latitude],
        options[:longitude],
        options[:guid] || "123456"
      ]
      
      results = response.body.split("|")
      if results[1].to_i < 0
        return {error: errors[results[1]]}
      else
        return {user_id: results[1], device_id: results[2], user_guid: results[3]}
      end
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
end