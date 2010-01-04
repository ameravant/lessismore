class Array
  def sort_alphabetically_by_material_category
    self.group_by(&:material_category_name).sort{|a,b| a[0]<=>b[0]}
  end
end