# frozen_string_literal: true
admin = User.find_or_initialize_by(email: "admin@example.com")
admin.password = "admin"
admin.save!
