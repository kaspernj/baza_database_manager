module ColumnsHelper
  def column_types_collection
    {
      t(".varchar") => "varchar",
      t(".text") => "text",
      t(".integer") => "int",
      t(".date") => "date",
      t(".datetime") => "datetime"
    }
  end
end
