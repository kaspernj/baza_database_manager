module ExpectHelpers
  def flash_messages
    find("div.alert").text
  rescue Capybara::ElementNotFound
    nil
  end
end
