# frozen_string_literal: true
module ColumnsHelper
  def column_types_collection
    {
      helper_t(".varchar") => "varchar",
      helper_t(".text") => "text",
      helper_t(".integer") => "int",
      helper_t(".date") => "date",
      helper_t(".datetime") => "datetime"
    }
  end
end
